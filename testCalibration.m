function testCalibration()
    % Ground truth parameters
    ground_truth_alpha = deg2rad(45);
    ground_truth_rotation = eye(3); % Ground truth rotation (identity matrix for no rotation)
    ground_truth_translation = [0; 0; 0]; % Ground truth translation (zero vector for no translation)

    % Markers in the ground truth robot frame
    M1 = [50; 0; -100];
    M2 = [0; 0; -100];
    M3 = [0; 0; -50];
    markers_robot_halfway = [M1, M2, M3]; % Assuming these are the marker positions at halfway point
    markers_robot_home = [M1, M2, M3];    % Assuming these are the marker positions at home position

    % Perform calibration using the given marker positions
    [T_calibrated, alpha_calibrated] = calibrateRobot(markers_robot_halfway, markers_robot_home);

    % Compare calibrated parameters with ground truth parameters
    rotation_calibrated = T_calibrated(1:3, 1:3); % Extract rotation matrix from transformation matrix
    translation_calibrated = T_calibrated(1:3, 4); % Extract translation vector from transformation matrix

    if isApproxEqual(rotation_calibrated, ground_truth_rotation) && ...
       isApproxEqual(translation_calibrated, ground_truth_translation) && ...
       isApproxEqual(alpha_calibrated, ground_truth_alpha)
        disp('Calibration successful.');
        disp('Calibrated parameters:');
        disp(T_calibrated);
        disp(rad2deg(alpha_calibrated));
        disp('Ground truth parameters:');
        disp(ground_truth_rotation);
        disp(ground_truth_translation);
        disp(rad2deg(ground_truth_alpha));
    else
        disp('Calibration failed.');
        disp('Calibrated parameters:');
        disp(T_calibrated);
        disp(rad2deg(alpha_calibrated));
        disp('Ground truth parameters:');
        disp(ground_truth_rotation);
        disp(ground_truth_translation);
        disp(rad2deg(ground_truth_alpha));
    end

end

% Helper function to approximate answers
function isEqual = isApproxEqual(a, b, tol)
    if nargin < 3
        tol = 1e-6;
    end
    isEqual = all(abs(a(:) - b(:)) < tol);
end