%----------------------- Begin Code Sequence -----------------------------%
% Purpose:                                                                %
% Convert ECI (CIS, Epoch J2000.0) Coordinates to WGS 84 (CTS, ECEF)      %
% Coordinates. This function has been vectorized for speed.               %
%                                                                         %
% Inputs:                                                                 %
%-------                                                                  %
%JD                     [1 x N]                         Julian Date Vector
%
%r_ECI                  [3 x N]                         Position Vector
%                                                       in ECI coordinate
%                                                       frame of reference
%
%v_ECI                  [3 x N]                         Velocity Vector in
%                                                       ECI coordinate
%                                                       frame of reference
%
%a_ECI                  [3 x N]                         Acceleration Vector
%                                                       in ECI coordinate
%                                                       frame of reference
%
%
% Outputs:
%---------                                                                %
%r_ECEF                 [3 x N]                         Position Vector in
%                                                       ECEF coordinate
%                                                       frame of reference
%
%v_ECEF                 [3 x N]                         Velocity vector in
%                                                       ECEF coordinate
%                                                       frame of reference
%
%a_ECEF                 [3 x N]                         Acceleration Vector
%                                                       in ECEF coordinate
%                                                       frame of reference
%
% References:
%-------------
%Orbital Mechanics with Numerit, http://www.cdeagle.com/omnum/pdf/csystems.pdf
%
%
% Function Dependencies:
%------------------
% JD2GMST
%------------------------------------------------------------------       %
% Programed by Darin Koblick  07-05-2010                                  %
% Modified on 03/01/2012 to add acceleration vector support       
% Modified on 5/3/2018 to simplify for CubeRRT needs
%------------------------------------------------------------------       %
function [r_ECEF,b_ECEF] = ECItoECEF_v2(JD,r_ECI,b_ECI)
%Enforce JD to be [N x 1]
JD = JD(:);

%Calculate the Greenwich Apparent Sideral Time (THETA)
%See http://www.cdeagle.com/omnum/pdf/csystems.pdf equation 27
THETA = JD2GAST(JD);

%Average inertial rotation rate of the earth radians per second
omega_e = 7.29211585275553e-005;

%Assemble the transformation matricies to go from ECI to ECEF
%See http://www.cdeagle.com/omnum/pdf/csystems.pdf equation 26
r_ECEF = squeeze(MultiDimMatrixMultiply(T3D(THETA),r_ECI));
b_ECEF = squeeze(MultiDimMatrixMultiply(T3D(THETA),b_ECI));

%----------------------------- End Code-----------------------------------%

function C = MultiDimMatrixMultiply(A,B)
C = sum(bsxfun(@times,A,repmat(permute(B',[3 2 1]),[size(A,2) 1 1])),2);

function T = T3D(THETA)
T = zeros([3 3 length(THETA)]);
T(1,1,:) = cosd(THETA);
T(1,2,:) = sind(THETA);
T(2,1,:) = -T(1,2,:);
T(2,2,:) = T(1,1,:);
T(3,3,:) = ones(size(THETA));
