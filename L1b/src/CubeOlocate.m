
function [SClat, SClon, SCalt, SCinc, blat, blon, binc,belev,bhorz] = CubeOlocate(ECI,Q_ECI,UTCtime,bsight)

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs:  
%   ECI [Nx3]:  position of spacecraft in Earth Center Inertial Frame in km
%   
%   Q_ECI [Nx4]:  Quaterion describing the orientation of the spacecraft
%   body from in the ECI frame (x-axis points in direction of velcoity,
%   z-axis points toward the center of the Earth and the y-axis completes
%   the coordinate system
%
%   UTCtime: [Nx1]  UTC time for the inputs
%
%   bsight: [3x1]:  boresight vector of the antenna in the spacecraft body
%   coordinate frame
%
% Outputs:  
%   SClat [1xN]:  Sub-spacecraft latitude in degrees
%   
%   SClon [1xN]:  Sub-spacecraft longitude in degrees
%   
%   SCalt [1xN]:  Sub-spacecraft altitude in km
%   
%   blat [1xN]:  antenna boresight latitude in degrees
%
%   blon [1xN]:  antenna boresight longitude in degrees
%   
%   binc [1xN]:  antenna boresight incidence angle wrt Earth normal of WGS84 elipsoid in degrees

jd = juliandate(datevec(UTCtime)); %Julian date from UTC time

R_SC_body = qGetR(Q_ECI); %get rotation matrix from quaterion

% Rotate boresight vector to spacecraft body frame in ECI
bvec_ECI = nan(3,size(ECI,1));
scvec_ECI = nan(3,size(ECI,1));
for k = 1:3
    bvec_ECI(k,:)= R_SC_body(:,k,1).*bsight(1,:)'+R_SC_body(:,k,2).*bsight(2,:)'+R_SC_body(:,k,3).*bsight(3,:)';
    scvec_ECI(k,:)= R_SC_body(:,k,3);
end
norm_vec = ones(3,1)*sqrt(sum(bvec_ECI.^2,1));
bvec_ECI=bvec_ECI./norm_vec;

[ECEFpos,ECEFbsight] = ECItoECEF_v2(jd,ECI',bvec_ECI); %convert ECI to ECEF using time

[SClat,SClon,SCalt] = ECEF2LLA(ECEFpos(1,:)*1000,ECEFpos(2,:)*1000,ECEFpos(3,:)*1000); %convert ECEF to lat,lon,altitude

norm_vec = ones(3,1)*sqrt(sum(ECEFbsight.^2,1));
ECEFbsight = ECEFbsight./norm_vec;
[ECEFintercept] = WGS84_intercept(ECEFpos.*1000, ECEFbsight); %find intercept of boresight vector with WGS84 elipsoid

ECEFintercept=real(ECEFintercept);
norm_vec = ones(3,1)*sqrt(sum(ECEFintercept.^2,1));
[blat,blon,balt] = ECEF2LLA(ECEFintercept(1,:),ECEFintercept(2,:),ECEFintercept(3,:)); %convert interncept point in ECEF to lat,lon,altitude
binc=180-acosd(dot(ECEFbsight,ECEFintercept./norm_vec)); %Incidence Angle wrt Earth Normal

norm_vec = ones(3,1)*sqrt(sum(ECEFpos.^2,1));
belev=180-acosd(dot(ECEFbsight,ECEFpos./norm_vec)); %Incidence Angle wrt Earth Normal

[ECEFposSC,ECEFbsightSC] = ECItoECEF_v2(jd,ECI',scvec_ECI); %convert ECI to ECEF using time
norm_vec = ones(3,1)*sqrt(sum(ECEFbsightSC.^2,1));
ECEFbsightSC = ECEFbsightSC./norm_vec;
norm_vec = ones(3,1)*sqrt(sum(ECEFposSC.^2,1));
SCinc=180-acosd(dot(ECEFbsightSC,ECEFposSC./norm_vec)); %Incidence Angle wrt Earth Normal

%Some conversions
SClat = SClat*180/pi; %rad to deg
SClon = SClon*180/pi; %rad to deg
SCalt = SCalt./1000; %m to km
blat = blat*180/pi; %rad to deg
blon = blon*180/pi; %rad to deg
%balt = balt./1000; %m to km

Re = 6378.37;
ThetaMax = asind(Re./(Re+SCalt));
bhorz = belev-ThetaMax;


