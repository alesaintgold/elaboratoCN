function yy = myspline( xi, fi, xx, type )
%
%   Se type è uguale a 0 allora calcola la spline cubica interpolante 
%   naturale i punti (xi(i),fi(i)), mentre se type è diverso da 0 allora 
%   calcola quella not-a-knot (default) 
%
%   Input:
%       xi:     vettore delle ascisse di interpolazione 
%       fi:     valori assunti dalla funzione nei rispettivi punti xi
%       xx:     ascisse su cui deve essere calcolata la spline
%       type:   valore che stabilisce il tipo di spline da creare
%   Output: 
%       yy:     valori assunti dalla spline nei rispettivi punti xx 
end