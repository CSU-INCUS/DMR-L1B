function sc = read_spacecraft(sc,c)
% %%% Example file from TEMPEST
% if (iscell(sc.filename.data))
%     M=[];
%     for mm = 1:length(sc.filename.data)
%         tmp = csvread(char(sc.filename.data{mm}), 0, 0);
%         M = cat(1,tmp,M);
%     end
% else
%     M = csvread(sc.filename.data, 1,0);
% end
% %%%
% 
% %order packets, remove duplicates
% [x indS] = sort(M(:,8)); %sort packets in ascending time
% indF = find(diff(x)>0); %remove duplicates
% while (numel(indF)<(numel(x)-1))
%     M=M(indS(indF),:);
%     [x indS] = sort(M(:,8)); %sort packets in ascending time
%     indF = find(diff(x)>0); %remove duplicates
% end
REFS_POSITION_WRT_ECI1 = ncread(sc.filename.data,'REFS_POSITION_WRT_ECI1');
REFS_POSITION_WRT_ECI2 = ncread(sc.filename.data,'REFS_POSITION_WRT_ECI2');
REFS_POSITION_WRT_ECI3 = ncread(sc.filename.data,'REFS_POSITION_WRT_ECI3');
ATT_DET_Q_BODY_WRT_ECI1 = ncread(sc.filename.data,'ATT_DET_Q_BODY_WRT_ECI1');
ATT_DET_Q_BODY_WRT_ECI2 = ncread(sc.filename.data,'ATT_DET_Q_BODY_WRT_ECI2');
ATT_DET_Q_BODY_WRT_ECI3 = ncread(sc.filename.data,'ATT_DET_Q_BODY_WRT_ECI3');
ATT_DET_Q_BODY_WRT_ECI4 = ncread(sc.filename.data,'ATT_DET_Q_BODY_WRT_ECI4');
% TIME_TAI_SECONDS = ncread(sc.filename.data,'TIME_TAI_SECONDS');
TIME_J2000_SECONDS = ncread(sc.filename.data,'TIME_J2000_SECONDS');

% Spacecraft information at its sample rate
sc.ECI.data = [REFS_POSITION_WRT_ECI1 REFS_POSITION_WRT_ECI2 REFS_POSITION_WRT_ECI3]; %x,y,z position in ECI frame in km

sc.Q_ECI.data = [ATT_DET_Q_BODY_WRT_ECI4 ATT_DET_Q_BODY_WRT_ECI1 ATT_DET_Q_BODY_WRT_ECI2 ATT_DET_Q_BODY_WRT_ECI3]; % the order originally used in TEMPEST code: M(:,[7,4:6]);  %S/C body orientation quaterion in ECI frame

sc.UTCtime.data = TIME_J2000_SECONDS-c.TAIoffset; % need to keep things in J2000, will set c.TAIoffset to account for differences between what I need for my data tests

sc.UTCtime_dt.data = sc.UTCtime.data./86400+datenum([2000 1 1 0 0 0]); % matlab dt
