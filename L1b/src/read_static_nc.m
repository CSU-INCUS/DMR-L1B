function d = read_static_nc(static_file)
% clear all; clc;
% static_file = 'C:\Users\marym\Documents\INCUS\code\DMR\dev\DMR-ground-processing\L1b\static\static_parameters.nc';
try
    d.file_info = ncinfo(static_file);   
    
    % read variables
    d.WLstart = ncread(static_file,'WLstart');
    d.WLend = ncread(static_file,'WLend');
    d.CSstart = ncread(static_file,'CSstart');
    d.CSend = ncread(static_file,'CSend');
    d.WLf = ncread(static_file,'WLf');
    d.CSf = ncread(static_file,'CSf');
    d.Tsky = ncread(static_file,'Tsky');
    d.calAvg = ncread(static_file,'calAvg');
    d.npkts = ncread(static_file,'npkts');
    d.TAIoffset = ncread(static_file,'TAIoffset');
    d.nadirang = ncread(static_file,'nadirang');
    d.scfrac = ncread(static_file,'scfrac');
    d.skyfrac = ncread(static_file,'skyfrac');
    d.calstd_thres = ncread(static_file,'calstd_thres');
    d.max_scan_for_geo = ncread(static_file,'max_scan_for_geo');
    d.max_scan_for_arr = ncread(static_file,'max_scan_for_arr');
    d.coefSCf = ncread(static_file,'coefSCf');
    d.minTA_qc = ncread(static_file,'minTA_qc');
    d.maxTA_qc = ncread(static_file,'maxTA_qc');
    d.SCinc_max = ncread(static_file,'SCinc_max');
    d.fill_val = ncread(static_file,'fill_val');
    d.param_Trx_x = ncread(static_file,'param_Trx_x');
    d.param_Trx_y = ncread(static_file,'param_Trx_y');
    fprintf('Successfully loaded all variables from %s\n', static_file);

catch ME
    fprintf('Error reading NetCDF file: %s\n', ME.message);
end