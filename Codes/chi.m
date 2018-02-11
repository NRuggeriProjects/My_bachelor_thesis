% creo la funzione caratteristica di un intervallo [a,b] chiuso

function y= chi(a,b,x)

% INPUT :   a,b estremi di un intervallo, x punto in cui calcolo la funzione
%           caratteristica


y=0.5.*( sign(x-a)+sign(b-x) ) + ...
     0.5.*(1-sign(abs(x-a)))  +  0.5.*(1-sign(abs(x-b)));
 
 % la prima riga e' somma di funzioni segno. La seconda aggiusta i valori
 % agli estremi a e b, aggiungendo 0.5 perche' valga 1 in a e b