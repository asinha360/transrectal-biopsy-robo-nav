# Transrectal Prostate Biopsy Robot Navigation using MRI

This project follows the calibration and kinematics of a transrectal biopsy robot that navigates using MRI to treat prostate tumours. All work for this project has been done for CISC 330 - Computer Integrated Surgery hosted by Dr. Gabor Fichtinger.

Calibration of the robot occurs in these roughly these steps:

- Initialize calibration sequence at halfway translation, rotation, and insertion
- Create MRI frame using central point between markers as origin
- Reset robot to home position and measure markers again
- Find transformation to robot frame from home position by finding the optimal Euclidean transformation in 3D space
- Transform markers to robot frame

Kinematics of the robot are evaluated in two steps - Forward and Inverse Kinematics

Inverse Kinematics computes the translation, rotation and needle insertion that moves the robot from home position to the target location.

Forward Kinematics computes the resulting location of robot using translation, rotation and needle insertion from the home frame position.

Read the documentation in [[HW-Robot-Nav.pdf]] for more detail
