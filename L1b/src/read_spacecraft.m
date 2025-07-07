function sc = read_spacecraft(sc,c)
%%% Example file from TEMPEST
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

sc.UTCtime.data = M(:,8)-c.TAIoffset; % keep things in J2000

sc.UTCtime_dt.data = M(:,8)./86400+datenum([2000 1 1 0 0 0])-c.TAIoffset./86400; % matlab dt
