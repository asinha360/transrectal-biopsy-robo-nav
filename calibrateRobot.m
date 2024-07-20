function [T_mri_to_robot, alpha_robot] = calibrateRobot(halfway_markers_mri, home_markers_mri)
    % Step 1: Initialize calibration sequence at halfway translation, rotation, and insertion

    % Step 2: Create MRI frame using central point between markers as origin
    origin_mri = mean(halfway_markers_mri(:, 1:3), 2);
    x_axis_mri = normalize(halfway_markers_mri(:, 2) - halfway_markers_mri(:, 1));
    y_axis_mri = normalize(halfway_markers_mri(:, 3) - halfway_markers_mri(:, 1));
    z_axis_mri = cross(x_axis_mri, y_axis_mri);

    alpha_mri = deg2rad(45);

    % Step 4: Reset robot to home position and measure M1, M2, and M3

    % Step 5: Use rigid_body_transform to find transformation to robot frame
    [rotation_mri, translation_mri] = Rigid_Body_Transform(halfway_markers_mri(:, 1:3), home_markers_mri(:, 1:3));

    % Step 6: Transform markers to robot frame
    T_mri_to_robot = [rotation_mri, translation_mri; 0 0 0 1];

    % Step 7: Compute alpha for the robot frame
    alpha_robot = alpha_mri;
end

% Helper function to normalize a vector
function vec = normalize(vec)
    vec = vec / norm(vec);
end

% Helper function for Rigid_Body_Transform function
function [rotation, translation] = Rigid_Body_Transform(P1, P2)
    % Adapted from - https://github.com/nghiaho12/rigid_transform_3D/blob/master/rigid_transform_3D.m
    % Ho, N. (2021, September 20). rigid_transform_3D. GitHub. https://github.com/nghiaho12/rigid_transform_3D/blob/master/rigid_transform_3D.m 
    A = P1' - mean(P1, 2)';
    B = P2' - mean(P2, 2)';
    [U, ~, V] = svd(A * B');
    rotation = V * U';  
    if det(rotation) < 0
        V(:, end) = -V(:, end);
        rotation = V * U';
    end
    translation = mean(P2, 2) - rotation * mean(P1, 2);
end