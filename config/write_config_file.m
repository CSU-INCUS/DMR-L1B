%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% write_config_file.m
% 
% This script writes the nc file that is used to store static parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;clc;

%% decide on file name
staticFolder = 'C:\Users\marym\Documents\INCUS\code\DMR\dev\DMR-ground-processing-public\DMR-ground-processing\L1b\static\';
fileName = 'static_parameters.nc';
staticFile = fullfile(staticFolder,fileName);
checkIfFileExists = dir(staticFile);
if(length(checkIfFileExists)>0)
    fileName = 'static_parameters_temp.nc';
    staticFile = fullfile(staticFolder,fileName);
    disp('Static File Exists, Writing to Temporary File')
end

%% define parameters
% WL_min_num = 4;
% nccreate(staticFile,'WL_min_num')
% ncwrite(staticFile,'WL_min_num',WL_min_num)
% ncwriteatt(staticFile,'WL_min_num','description','minimum number of warm look obs needed for good calibration')
% 
% CS_min_num = 4;
% nccreate(staticFile,'CS_min_num')
% ncwrite(staticFile,'CS_min_num',CS_min_num)
% ncwriteatt(staticFile,'CS_min_num','description','minimum number of cold look obs needed for good calibration')

EIA_max = 60;
nccreate(staticFile,'EIA_max')
ncwrite(staticFile,'EIA_max',EIA_max)
ncwriteatt(staticFile,'EIA_max','description','EIA limit for observations deemed too oblique')

WLstart = 6149;  %encoder position of warm load boundary 
nccreate(staticFile,'WLstart')
ncwrite(staticFile,'WLstart',WLstart)
ncwriteatt(staticFile,'WLstart','description','starting encoder position of warm load boundary')

WLend = 7949;  %encoder position of warm load boundary 
nccreate(staticFile,'WLend')
ncwrite(staticFile,'WLend',WLend)
ncwriteatt(staticFile,'WLend','description','ending encoder position of warm load boundary')

CSstart = 13549;  %encoder position of cold sky boundary 
nccreate(staticFile,'CSstart')
ncwrite(staticFile,'CSstart',CSstart)
ncwriteatt(staticFile,'CSstart','description','starting encoder position of cold sky boundary')

CSend = 14614;  %encoder position of cold sky boundary 
nccreate(staticFile,'CSend')
ncwrite(staticFile,'CSend',CSend)
ncwriteatt(staticFile,'CSend','description','ending encoder position of cold sky boundary')

WLf = 1;  % warm load fill fraction (1-spillover)
nccreate(staticFile,'WLf')
ncwrite(staticFile,'WLf',WLf)
ncwriteatt(staticFile,'WLf','description','warm load fill fraction (1-spillover)')

CSf = 1;  % cold sky fill fraction (1-spillover)
nccreate(staticFile,'CSf')
ncwrite(staticFile,'CSf',CSf)
ncwriteatt(staticFile,'CSf','description','cold sky fill fraction (1-spillover)')

Tsky = 2.73;  % Brightness temperature of cold sky
nccreate(staticFile,'Tsky')
ncwrite(staticFile,'Tsky',Tsky)
ncwriteatt(staticFile,'Tsky','description','Brightness temperature of cold sky')

calAvg = 15;  % number of scans to average calibration data
nccreate(staticFile,'calAvg')
ncwrite(staticFile,'calAvg',calAvg)
ncwriteatt(staticFile,'calAvg','description','number of scans to average calibration data')

npkts = -1;%22412;%34829;  % data granule size in number of packets (0.5s/pkt)
nccreate(staticFile,'npkts')
ncwrite(staticFile,'npkts',npkts)
ncwriteatt(staticFile,'npkts','description','data granule size in number of packets (0.5s/pkt)')

TAIoffset =  -2.286967861699987e+07;  % used for conversion of S/C time to instrument J2000 time currently
nccreate(staticFile,'TAIoffset')
ncwrite(staticFile,'TAIoffset',TAIoffset)
ncwriteatt(staticFile,'TAIoffset','description','seconds TAI is ahead of UTC')

nadirang = 46;  %scan angle of nadir for encoder 
nccreate(staticFile,'nadirang')
ncwrite(staticFile,'nadirang',nadirang)
ncwriteatt(staticFile,'nadirang','description','scan angle of nadir for encoder')

scfrac = [0.01,0.01,0.01,0.01,0.01]; % APC spacecraft fraction
nccreate(staticFile,'scfrac','Dimensions',{'scfrac',1,5})
ncwrite(staticFile,'scfrac',scfrac)
ncwriteatt(staticFile,'scfrac','description','APC spacecraft fraction')

skyfrac = [0.01,0.01,0.01,0.01,0.01];  % APC cold sky fraction
nccreate(staticFile,'skyfrac','Dimensions',{'skyfrac',1,5})
ncwrite(staticFile,'skyfrac',skyfrac)
ncwriteatt(staticFile,'skyfrac','description','APC cold sky fraction')

calstd_thres = [200 300 400 300 500];  %threshold to filter calibration counts standard deviation on single target look
nccreate(staticFile,'calstd_thres','Dimensions',{'calstd_thres',1,5})
ncwrite(staticFile,'calstd_thres',calstd_thres)
ncwriteatt(staticFile,'calstd_thres','description','threshold to filter calibration counts standard deviation on single target look')

max_scan_for_geo = 180;  %maximum scan angle from nadir to compute geolocation, 65deg is default, 180 computes entire scan for off-pointing cases
nccreate(staticFile,'max_scan_for_geo')
ncwrite(staticFile,'max_scan_for_geo',max_scan_for_geo)
ncwriteatt(staticFile,'max_scan_for_geo','description','maximum scan angle from nadir to compute geolocation, 65deg is default, 180 computes entire scan for off-pointing cases')

max_scan_for_arr = 180;  %maximum scan angle from nadir to compute geolocation, 70deg is default, 180 computes entire scan for off-pointing cases
nccreate(staticFile,'max_scan_for_arr')
ncwrite(staticFile,'max_scan_for_arr',max_scan_for_arr)
ncwriteatt(staticFile,'max_scan_for_arr','description','maximum scan angle from nadir to compute geolocation, 70deg is default, 180 computes entire scan for off-pointing cases')

% spill over coefficients into spacecraft
coefSCf(:,5)=[1.0730e-11  -1.6894e-09  -4.9927e-07  -4.9854e-06 1.0];
for ch = 1:4
    coefSCf(:,ch)=[-3.8687e-11  -1.6974e-09   4.1721e-07   2.1425e-06 1.0];
end
nccreate(staticFile,'coefSCf','Dimensions',{'x',5,'y',5})
ncwrite(staticFile,'coefSCf',coefSCf)
ncwriteatt(staticFile,'coefSCf','description','spill over coefficients into spacecraft')

minTA_qc = 0;  %minimum TA to allow
nccreate(staticFile,'minTA_qc')
ncwrite(staticFile,'minTA_qc',minTA_qc)
ncwriteatt(staticFile,'minTA_qc','description','minimum TA to allow')

maxTA_qc = 320; %maximum TA to allow
nccreate(staticFile,'maxTA_qc')
ncwrite(staticFile,'maxTA_qc',maxTA_qc)
ncwriteatt(staticFile,'maxTA_qc','description','maximum TA to allow')

SCinc_max = 2; %maximum off-nomnial pointing to allow
nccreate(staticFile,'SCinc_max')
ncwrite(staticFile,'SCinc_max',SCinc_max)
ncwriteatt(staticFile,'SCinc_max','description','maximum off-nomnial pointing to allow')

fill_val = -999; %fill value to use for bad data
nccreate(staticFile,'fill_val')
ncwrite(staticFile,'fill_val',fill_val)
ncwriteatt(staticFile,'fill_val','description','fill value to use for bad data')


param_Trx_x = [268.986250474349	276.093231118191	285.470760465527	293.771343563665	303.438562241069	311.710694317071;...
268.401163247236	275.542715472093	285.295711822495	293.692436884875	303.612605555810	311.383282103762;...
268.401163247236	275.542715472093	285.295711822495	293.692436884875	303.612605555810	311.383282103762;...
268.401163247236	275.542715472093	285.295711822495	293.692436884875	303.612605555810	311.383282103762;...
268.401163247236	275.542715472093	285.295711822495	293.692436884875	303.612605555810	311.383282103762];
nccreate(staticFile,'param_Trx_x','Dimensions',{'f',5,'T',6})
ncwrite(staticFile,'param_Trx_x',param_Trx_x)
ncwriteatt(staticFile,'param_Trx_x','description','Temperature points for Trx parameterization, W10 Temps for Ch 1, WR5FE for all other channels')

param_Trx_y = [364.014310884999	382.179785981455	405.480121190854	426.414269389063	453.048575792933	479.607883437636;...
394.371824946406	404.829506018767	419.931296195448	433.385280532577	449.252484794308	461.196049692868;...
428.258419702543	441.038739670457	460.669860006310	477.939375180889	498.116123698722	512.964097806432;...
572.537518237723	614.762417049017	646.654994094990	675.718575036923	711.674610433599	740.101839761131;...
637.227809879538	675.374116578273	719.998368950494	762.072246432368	815.970455639697	860.105835453326];
nccreate(staticFile,'param_Trx_y','Dimensions',{'f',5,'T',6})
ncwrite(staticFile,'param_Trx_y',param_Trx_y)
ncwriteatt(staticFile,'param_Trx_y','description','Trx points for Trx parameterization')

