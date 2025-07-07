clear all;
clc;
% need to create the s/c file as if it overlapped with our DMR data
% number of seconds between '15-Sep-2019 23:47:57' and '28-Feb-2025 02:37:14'
secondsPerDay = 24*60*60;
tm0DMR = datenum('28-Feb-2025 02:37:14');  
tm1DMR = datenum('28-Feb-2025 03:11:22');

tm0BCT = datenum('15-Sep-2019 23:47:57');
tmDiff = tm0BCT - tm0DMR; % days
tmDiffSeconds = tmDiff.*secondsPerDay;

% config.TAIoffset = tmDiffSeconds;
% sc.filename.data = 'C:\Users\marym\Documents\INCUS\code\TEMPEST\code_archive\L0\spacecraft\tempest_SOH_20190915.csv';
config.TAIoffset = 0;
sc.filename.data = 'C:\Users\marym\Documents\INCUS\code\DMR\dev\DMR-ground-processing\L0\outputs\L0_sc_fake.csv';
if (iscell(sc.filename.data))
    M=[];
    for mm = 1:length(sc.filename.data)
        tmp = csvread(char(sc.filename.data{mm}), 0, 0);
        M = cat(1,tmp,M);
    end
else
    M = csvread(sc.filename.data, 1,0);
end
%%%

%order packets, remove duplicates
[x indS] = sort(M(:,8)); %sort packets in ascending time
indF = find(diff(x)>0); %remove duplicates
while (numel(indF)<(numel(x)-1))
    M=M(indS(indF),:);
    [x indS] = sort(M(:,8)); %sort packets in ascending time
    indF = find(diff(x)>0); %remove duplicates
end

% Spacecraft information at its sample rate
sc.ECI.data = M(:,1:3); %x,y,z position in ECI frame in km

sc.Q_ECI.data = M(:,[7,4:6]);  %S/C body orientation quaterion in ECI frame

sc.UTCtime.data = M(:,8) - config.TAIoffset; % keep things in J2000


% goes until '28-Feb-2025 02:49:52'
