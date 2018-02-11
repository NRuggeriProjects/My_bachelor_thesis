% FUNCTION  di veririfica ipotesi i),ii),iii)

function verifica_ipotesi(p_0,q, beta)

% INPUT:    p_0,q: densita' delle distribuzioni relative ad adattamento e
%                  mutazione (input come funzioni)
%           beta: coefficiente che definisce il rinnovo delle generazioni
%                 appartenente a (0,1)


% IPOTESI 1         % integranda q(dx)/1-x
g= chebfun(@(x) q(x)./(1-x),[0 1],'splitting','on');
 
I=sum(g);           % sum e' il comando di integrazione per funzioni chebfun
v1= I<= 1/beta;     % variabile logica (1 o 0) sulla veridicita' di ipotesi 1
fprintf('\n IPOTESI 1 VERIFICATA: \t %d \n',v1)

% calcolo le m_n e mu_n (registrate nei vettori m e mu) cosi' come le f_n e
% u_n, necessari per ipotesi 2 e 3
m=[]; mu=[]; u=[];
leng=400;
for n=1:leng     
    m(n)=sum( chebfun(@(x) x.^n .*q(x),[0 1],'splitting','on'));      
    mu(n)=sum( chebfun(@(x) x.^n .*p_0(x),[0 1],'splitting','on'));
end
f=beta./(1-beta).* mu;
for n=1:leng
    u(n)=dot(f(1:n-1),u(n-1:-1:1) );  % definizione ricorsiva di u_n 
end

% IPOTESI 2
plot(2:leng,mu(2:leng)./mu(1:leng-1)) 
title('verifica ipotesi: andamento del rapporto u_n/u_{n-1}')
print('ipotesi2','-djpeg');         % salva il grafico in formato jpg

% IPOTESI 3
figure;
plot(1:leng,m./mu)
title('rapporto m_n/mu_n al crescere di n')
print('ipotesi3','-djpeg');










