function [translation, rotation, insertion] = inverseKinematics(target_point)
    alpha = deg2rad(45);

    % Extract the coordinates of the target point
    x_target = target_point(1);
    y_target = target_point(2);
    z_target = target_point(3);

    % Rotation around the Z-axis (yaw)
    rotation = atan2(y_target, x_target);

    % Translation along the Z-axis - height at base of the needle
    translation = z_target;

    % Calculate the effective reach in the XY-plane - 
    % distance from the robot's axis to the target point
    effective_reach = sqrt(x_target^2 + y_target^2);

    % Calculate the true insertion depth
    % needle's path as hypotenuse
    insertion = effective_reach / cos(alpha);

    % Adjust translation based on alpha and insertion
    % accounts for the vertical component of the insertion
    vertical_component = insertion * sin(alpha);
    translation = translation - vertical_component;

    % Output the computed values
end

% 'Test Module' - uncomment and copy paste into command window
% alpha = deg2rad(45); % Needle exit angle of 45 degrees
% target_point = [10, 10, 5]; % Example target point in Frob robot frame
% 
% [translation, rotation, insertion] = inverseKinematics(target_point);
% 
% % Display the results
% disp(['Translation (Z-axis): ', num2str(translation), ' mm']);
% disp(['Rotation (Yaw): ', num2str(rad2deg(rotation)), ' degrees']);
% disp(['Needle Insertion Depth: ', num2str(insertion), ' mm']);