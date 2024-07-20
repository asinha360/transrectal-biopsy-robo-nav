function kinematicTest()
    N = 10; % Number of random points to test
    alpha = deg2rad(45); % Exit angle of 45 degrees in radians

    % Define workspace limits
    x_limits = [0, 80];
    y_limits = [-80, 80];
    z_limits = [0, 60];

    for i = 1:N
        % Generate a random target point within the workspace
        x_target = randRange(x_limits);
        y_target = randRange(y_limits);
        z_target = randRange(z_limits);
        target_point = [x_target; y_target; z_target];

        % Compute inverse kinematics parameters for this target
        [translation, rotation, insertion] = inverseKinematics(target_point);

        % Use calculated parameters in forward kinematics
        needle_tip_calculated = forwardKinematics(translation, rotation, insertion);

        % Check if calculated needle tip matches the target coords
        if isApproxEqual(target_point, needle_tip_calculated)
            disp(['Test ', num2str(i), ': Success']);
            disp('Target Point:');
            disp(target_point');
            disp('Calculated Needle Tip:');
            disp(needle_tip_calculated');
        else
            disp(['Test ', num2str(i), ': Failure']);
            disp('Target Point:');
            disp(target_point');
            disp('Calculated Needle Tip:');
            disp(needle_tip_calculated');
        end
    end
end

% Helper function to generate a random number within a specified range
function num = randRange(limits)
    num = limits(1) + (limits(2) - limits(1)) * rand();
end

% Helper function for approximate equality check
function isEqual = isApproxEqual(vec1, vec2, tol)
    if nargin < 3, tol = 1e-6; end 
    % from - https://www.mathworks.com/help/matlab/ref/uniquetol.html
    isEqual = all(abs(vec1 - vec2) < tol);
end