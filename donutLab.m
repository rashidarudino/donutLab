r = 1;
R = 2;
numSprinkles = 100;

% Define theta and phi for donut shape
theta = linspace(0, 2 * pi, 100);
phi = linspace(0, 2 * pi, 30);
[thetaGrid, phiGrid] = meshgrid(theta, phi);

% Calculate coordinates for the donut
X = (R + r * cos(phiGrid)) .* cos(thetaGrid);
Y = (R + r * cos(phiGrid)) .* sin(thetaGrid);
Z = r * sin(phiGrid);

% Generate random sprinkles
thetaSprinkles = pi * rand(1, numSprinkles);
phiSprinkles = 2 * pi * rand(1, numSprinkles);
X_sprinkles = (R + r * cos(thetaSprinkles)) .* cos(phiSprinkles);
Y_sprinkles = (R + r * cos(thetaSprinkles)) .* sin(phiSprinkles);
Z_sprinkles = r * sin(thetaSprinkles);

% Define sprinkle colors
colors = [
    1.0 0.8 0.8; % Light Pink
    1.0 0.9 0.6; % Light Yellow
    0.8 1.0 0.8; % Light Mint
    0.8 0.8 1.0; % Light Blue
];

% Randomly select colors for sprinkles
colorSprinkles = colors(randi(size(colors, 1), numSprinkles, 1), :);

% Create figure and adjust properties
figure('Position', [100, 100, 800, 600]);
axis equal off;
view(3);
hold on;

% Define dough color
doughColor = [255 / 255, 175 / 255, 100 / 255];
surf(X, Y, Z, 'FaceColor', doughColor, 'EdgeColor', 'none', ...
     'FaceLighting', 'gouraud', 'AmbientStrength', 0.3);

% Icing parameters
[thetaIcing, phiIcing] = meshgrid(linspace(0, 2 * pi, 100), linspace(0, pi / 2, 30));
rIcing = r * 1.05;
zIcing = r * sin(phiIcing) + 0.1 * sin(2 * pi * thetaIcing);

xIcingInner = (R - rIcing * cos(phiIcing)) .* cos(thetaIcing);
yIcingInner = (R - rIcing * cos(phiIcing)) .* sin(thetaIcing);
zIcingInner = zIcing;

xIcing = (R + rIcing * cos(phiIcing)) .* cos(thetaIcing);
yIcing = (R + rIcing * cos(phiIcing)) .* sin(thetaIcing);

% Combine icing coordinates
xIcingCombined = [xIcingInner; xIcing];
yIcingCombined = [yIcingInner; yIcing];
zIcingCombined = [zIcingInner; zIcing];

% Define icing color and properties
icingColor = [1, 0.6, 0.6];
icingSurface = surf(xIcingCombined, yIcingCombined, zIcingCombined, ...
                    'FaceColor', icingColor, 'EdgeColor', 'none', ...
                    'FaceLighting', 'gouraud', 'FaceAlpha', 0.9); % More opaque icing

% Add lighting effects
light('Position', [-1, 1, 0.5], 'Style', 'infinite');
light('Position', [1, -1, -0.5], 'Style', 'infinite');
light('Position', [0, 0, 1], 'Style', 'infinite');
set(gca, 'AmbientLightColor', [0.8, 0.8, 0.8]);

brownColor = [0.5, 0.25, 0];
scatter3(X_sprinkles, Y_sprinkles, Z_sprinkles, 30, colorSprinkles, 'filled', 'MarkerEdgeColor', brownColor);

% Animation parameters
frames = 700;
spinSpeed = 100 / frames;
azimuth = 0;

while true
    for k = 1:frames
        Z_icing = r * sin(phiIcing);
        Z_icing_inner = Z_icing;
        set(icingSurface, 'ZData', [Z_icing_inner; Z_icing]);

        % Update view angle for rotation
        azimuth = mod(azimuth + spinSpeed, 360);
        view(azimuth, 30);
        drawnow;
    end
end
