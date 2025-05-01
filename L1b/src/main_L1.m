%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% main_L1.m
% 
% This is the main script that includes all code for producing geolocated
% TA and TB
% eventually I will make this a function that takes an input file, but for
% now I will hard code a nc file input path
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; clc;

%% define directories ----------------------------------------------------%
L0_file = 'C:\Users\marym\Documents\INCUS\code\DMR\dev\DMR-ground-processing\L0\outputs\tlm.080.nc';
static_folder = 'C:\Users\marym\Documents\INCUS\code\DMR\dev\DMR-ground-processing\L1b\static\';
static_file = 'C:\Users\marym\Documents\INCUS\code\DMR\dev\DMR-ground-processing\L1b\static\static_parameters.nc';
%% load static parameters ------------------------------------------------%

%% load L0 data ----------------------------------------------------------%
d = read_L0_nc(L0_file);

%% load spacecraft telemetry ---------------------------------------------%

%% data organization, conversions (e.g. scan angle) ----------------------%

%% observing geometry ----------------------------------------------------%

%% extract calibration data ----------------------------------------------%

%% compute TA ------------------------------------------------------------%

%% compute TB ------------------------------------------------------------%

%% filter and flag data --------------------------------------------------%

%% output HDF ------------------------------------------------------------%