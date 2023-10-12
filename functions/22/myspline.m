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
if nargin < 3, error("argomenti essenziali assenti"); end
if nargin == 3, type = 1; end
if size(xi) ~= size(fi), error("Le quantità di dati forniti per " + ...
        "l'interpolazione non corrispondono"); end
if length(xi) ~= length(unique(xi)), error("Le ascisse di " + ...
        "interpolazione devono essere tutte distinte tra loro");end
% si utilizzerà la fattorizzazione LU per trovare i membri m0...mn +
load("../8/mialu.m");
end