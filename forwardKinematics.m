function needle_tip = forwardKinematics(translation, rotation, insertion)
    alpha = deg2rad(45);

    % Decompose the needle insertion into its XY-plane and Z-axis components
    insertion_xy = insertion * cos(alpha);  % Projection of insertion on XY-plane
    insertion_z = insertion * sin(alpha);   % Vertical component of insertion

    % Calculate needle tip position in the Frob frame
    needle_tip_x = insertion_xy * cos(rotation);
    needle_tip_y = insertion_xy * sin(rotation);
    needle_tip_z = translation + insertion_z; % Adjusted for vertical component

    % Combine into a single vector
    needle_tip = [needle_tip_x; needle_tip_y; needle_tip_z];
end

% 'Test Module' - uncomment and copy paste into command window
% translation = 5;
% rotation = deg2rad(45);
% insertion = 20;
% 
% needle_tip = forwardKinematics(translation, rotation, insertion);
% 
% % Display the result
% disp('Needle tip position in Frob frame:');
% disp(needle_tip);