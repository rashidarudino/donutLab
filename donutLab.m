r=1; R=2; numDots=100;
[thetaGrid, phiGrid] = meshgrid(linspace(0, 2*pi, 100), linspace(0, 2*pi, 30));
X = (R + r*cos(phiGrid)) .* cos(thetaGrid); Y = (R + r*cos(phiGrid)) .* sin(thetaGrid); Z = r*sin(phiGrid);

thetaDots = pi*rand(1, numDots); phiDots = 2*pi*rand(1, numDots);
xDots = (R + r*cos(thetaDots)) .* cos(phiDots); yDots = (R + r*cos(thetaDots)) .* sin(phiDots); zDots = r*sin(thetaDots);

colors = [1.0, 0.8, 0.8; 1.0, 0.9, 0.6; 0.8, 1.0, 0.8; 0.8, 0.8, 1.0];
colorDots = colors(randi(4, numDots, 1), :);

figure('Position', [100, 100, 800, 600]); axis equal off; view(3); hold on;
surf(X, Y, Z, 'FaceColor', [1, 0.686, 0.392], 'EdgeColor', 'none', 'FaceLighting', 'gouraud', 'AmbientStrength', 0.3);

[thetaIcing, phiIcing] = meshgrid(linspace(0, 2*pi, 100), linspace(0, pi/2, 30));
rIcing = r * 1.05; 
zIcing = r * sin(phiIcing) + 0.1 * sin(2*pi*thetaIcing);
xIcingInner = (R - rIcing*cos(phiIcing)) .* cos(thetaIcing);
yIcingInner = (R - rIcing*cos(phiIcing)) .* sin(thetaIcing);
xIcing = (R + rIcing*cos(phiIcing)) .* cos(thetaIcing);
yIcing = (R + rIcing*cos(phiIcing)) .* sin(thetaIcing);

icingSurface = surf([xIcingInner; xIcing], [yIcingInner; yIcing], [zIcing; zIcing], ...
    'FaceColor', [1, 0.6, 0.7], 'EdgeColor', 'none', 'FaceLighting', 'gouraud', 'FaceAlpha', 0.8);

light('Position', [-1, 1, -.5], 'Style', 'infinite'); light('Position', [1, -1, -.5], 'Style', 'infinite'); light('Position', [0, 0, 1], 'Style', 'infinite');
set(gca, 'AmbientLightColor', [0.8, 0.8, 0.8]);
material shiny;
scatter3(xDots, yDots, zDots, 30, colorDots, 'filled', 'MarkerEdgeColor', [0.5, 0.25, 0]);

frames = 700; spinSpeed = 100/frames; azimuth = 0;
while true
    for k = 1:frames
        set(icingSurface, 'ZData', [r * sin(phiIcing); r * sin(phiIcing)]);
        azimuth = mod(azimuth + spinSpeed, 360);
        view(azimuth, 25); 
        drawnow;
    end
end
