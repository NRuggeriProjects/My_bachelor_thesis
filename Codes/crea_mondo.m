p_0=@(x) 0.*x +1.0;       
q= @(x) sin(1-x)./(1-cos(1));
alpha=2;
beta=0.1;           % ipotesi 1 verificata per 0.4 non per 0.5
steps=1000;


verifica_ipotesi(p_0,q,beta)

y=input('le ipotesi sono verificate? immettere variabile logica:    ');

if y==0
    fprintf('ipotesi non verificate, termino il processo \n')
    return
elseif y==1
    evoluzione(p_0,q,beta,steps,alpha)
else
    y=input('variabile non valida. Immettere variabile logica 1=VERO oppure 0=FALSO:     ');
end