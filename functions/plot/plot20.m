addpath(genpath('../20'));
addpath(genpath('../19'));

tl = tiledlayout(2,2);
title(tl,'Approsimazione della costante di Lebesgue');

%t.Padding = "compact";
tl.TileSpacing = 'compact';

plotlebesgue(0,1,0);
plotlebesgue(0,1,1);
plotlebesgue(-3,7,0);
plotlebesgue(-3,7,1);


function tt = plotlebesgue(a,b,type)
    tt = nexttile;
    plot(lebesgue(a,b,(1:100),type));    
    if type == 0
        t = title("Ascisse equidistanti");
    elseif type == 1
        t = title("Ascisse di Chebyshev");
    end
    xlabel(tt,'Grado del polinomio');
    ylabel(tt,'Costante di Lebesgue');

    s = subtitle("Intervallo [" + string(a) + ", " + string(b) +"]");
    %t.FontSize = 8;
    %s.FontSize = 6;
    s.FontAngle = 'italic';
end

