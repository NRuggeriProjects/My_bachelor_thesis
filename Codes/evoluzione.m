function evoluzione(p_0,q,beta,steps,alpha)

% INPUT:  p_0,q: funzioni che danno la densita' delle misure relative
%         beta: parametro che determina l'evoluzione
%         steps: numero di generazioni da considerare
%         alpha: parametro come in teorema su comportamento asintotico


asint=zeros(steps,2);       % matrice con colonna 1: valori di p_n(1-x/n,1)
                            % colonna 2: integrale a cui dorebbe convergere
 
p= @(x) beta.*q(x)./(1-x);  % distribuzione limite teorico senza delta in 1


w0= sum(chebfun(@(x) x.*p_0(x) ,[0 1],'splitting','on'));
p_prec= @(x) (1-beta)./w0.*x.*p_0(x)+ beta.*q(x);


xsup=10;


k=(1-sum(chebfun(p,[0 1],'splitting','on')))./gamma(alpha).*integral(@(y) y.^(alpha-1).*exp(-y) ,0,xsup);

asint(1,:)=[sum(chebfun(p_prec,[1-xsup 1],'splitting','on'))   k];

figure; fplot(p,[0 1]);         
axis([0 1 0 2])     % impone i limiti di grandezza degli assi
title('funzioni di densita delle generazioni e del limite')

hold on
for n=2:steps
    w= sum(chebfun(@(x) x.*p_prec(x),[0 1],'splitting','on'));
    p_new=@(x) (1-beta).*x.*p_prec(x)./w + beta.*q(x);
    if rem(n,50)==0         % plotto una generazione ogni 50
        fplot(p_new,[0 1]);
    end
    if rem(n,100)==0
        fprintf('\n ho effettuato %d iterazioni ',n)
    end
    % per lo stesso motivo di prima, preferisco integrare una funzione
    % chebfun e memorizzare in asint il valore
    pcheb=chebfun(p_new,[1-xsup./n 1],'splitting','on'); 
    asint(n,:)=[sum(pcheb) k];
    p_prec=p_new;   
end
hold off
print('densita_limite','-djpeg'); 

figure; plot(1:steps,asint(:,1),'k',1:steps,asint(:,2),'b')
axis([0 steps asint(1,2)-0.1 asint(1,2)+0.1]);
title('andamento dei valori integrali limite')
print('integrali_limite','-djpeg'); 

asint




