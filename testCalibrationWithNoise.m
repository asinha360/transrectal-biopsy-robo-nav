function testCalibrationWithNoise()
    % Ground truth parameters
    ground_truth_alpha = deg2rad(45);
    ground_truth_rotation = eye(3); % Ground truth rotation (identity matrix for no rotation)
    ground_truth_translation = [0; 0; 0]; % Ground truth translation (zero vector for no translation)

    % Markers in the ground truth robot frame
    M1 = [50; 0; -100];
    M2 = [0; 0; -100];
    M3 = [0; 0; -50];
    markers_robot_halfway = [M1, M2, M3]; % Marker positions at halfway point

    % Add normally distributed random noise to the marker positions
    noise_std = 1.0; % Standard deviation of noise
    noisy_markers_halfway = markers_robot_halfway + noise_std * randn(size(markers_robot_halfway));

    % Perform calibration with noisy marker positions
    [T_calibrated_noisy, alpha_calibrated_noisy] = calibrateRobot(noisy_markers_halfway, markers_robot_halfway);

    % Compute the differences in calibration parameters
    rotation_difference = norm(T_calibrated_noisy(1:3, 1:3) - ground_truth_rotation, 'fro');
    translation_difference = norm(T_calibrated_noisy(1:3, 4) - ground_truth_translation);
    alpha_difference = abs(alpha_calibrated_noisy - ground_truth_alpha);

    % Display differences
    disp('Differences in calibration parameters due to noise:');
    disp(['Rotation difference: ', num2str(rotation_difference)]);
    disp(['Translation difference: ', num2str(translation_difference)]);
    disp(['Alpha difference (radians): ', num2str(alpha_difference)]);

    % Assume the target is the prostate center at the origin [0; 0; 0]
    prostate_center = [0; 0; 0];
    prostate_center_calibrated = T_calibrated_noisy * [prostate_center; 1];
    targeting_error = norm(prostate_center_calibrated(1:3) - prostate_center);

    disp(['Targeting error (mm): ', num2str(targeting_error)]);
end