% based on run_CubeOlocate
function sc = process_spacecraft_data(sc)

sc.R_ECI.data = qGetR(sc.Q_ECI.data);  % rotation matrix from bodyframe to ECI using SOH

%% Getting rotation of body frame in ECI for level flight
vsat= sc.ECI.data(2:end,:)-sc.ECI.data(1:end-1,:);
norm_val=sqrt(sum(vsat.^2,2))*ones(1,3);
vsat= -vsat./norm_val;
zsat = -sc.ECI.data(1:end-1,:); % define z vector of sat pointing down
norm_val=sqrt(sum(zsat.^2,2))*ones(1,3);
zsat=zsat./norm_val;
sc.R_ECI_LVL.data=nan(size(vsat,1),3,3); % coordinate system
sc.R_ECI_LVL.data(:,:,1) = vsat;
sc.R_ECI_LVL.data(:,:,3) = zsat;
sc.R_ECI_LVL.data(:,:,2) = cross(zsat,vsat);

%% Deriving roll, pitch and yaw from level body frame
sc.yaw.data=nan(size(sc.ECI.data,1),1);
sc.pitch.data=nan(size(sc.ECI.data,1),1);
sc.roll.data=nan(size(sc.ECI.data,1),1);
Reul=nan(size(sc.R_ECI_LVL.data)); %rotation matrix between level flight frame and SOH body orientation
for k = 1:length(sc.R_ECI_LVL.data)
    Reul(k,:,:)= (squeeze(sc.R_ECI_LVL.data(k,:,:)))\squeeze(sc.R_ECI.data(k,:,:)); % rotation matrix between level flight assumption and s/c (ECI)
end
sc.yaw.data(1:size(Reul,1)) = atan2(Reul(:,2,1), Reul(:,1,1))*180/pi; %counterclockwise rotation about the S/C z-axis
sc.pitch.data(1:size(Reul,1)) = atan2(-Reul(:,3,1), sqrt(Reul(:,3,2).^2+Reul(:,3,3).^2))*180/pi; %counterclockwise rotation about the S/C y-axis
sc.roll.data(1:size(Reul,1)) = atan2(Reul(:,3,2),Reul(:,3,3))*180/pi; %counterclockwise rotation about the S/C x-axis

%% get info for nominal nadir boresight
%%% not sure if these constants need to be changed for DMR
bsight = [0 0 1]'; % nominal boresight in instrument coordinate frame
roll = 0; % possible mis-aligment of antenna boresight in roll [degrees]
pitch = 0;  % possible mis-aligment of antenna boresight in pitch [degrees]
yaw = 180;  % possible mis-aligment of antenna boresight in yaw [degrees] 
Rroll = getR(roll, 'x');
Rpitch = getR(pitch, 'y');
Ryaw = getR(yaw, 'z');
bsight_SC = Ryaw*Rpitch*Rroll*bsight;  % nominal boresight in spacecraft coordinate frame accounting for mis-allignments between inst/SC frames

%% compute the S/C samples 
[sc.lat.data, sc.lon.data, sc.alt.data, ~, ~, ~] = CubeOlocate(sc.ECI.data,sc.Q_ECI.data,sc.UTCtime_dt.data,bsight_SC); 

%% compute ascending and descending flags
tmp=diff(sc.lat.data)./diff(sc.UTCtime.data');
sc.asds.data=zeros(size(sc.lat.data));
ind = find(tmp>0);
sc.asds.data(ind)=1;

