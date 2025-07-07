function output_netcdf(rad,cal,sc,output_file)

nccreate(output_file,"/Ancillary/obs_land_flag", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Ancillary/obs_land_flag",rad.landmask.data)

nccreate(output_file,"/CalibratedSceneTemperatures/earth_inc_flag", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/earth_inc_flag",rad.earth_inc_flag.data)

nccreate(output_file,"/CalibratedSceneTemperatures/obs_qual_flag", "Dimensions",{"Nobs",length(rad.landmask.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/obs_qual_flag",rad.obs_qual_flag.data)

nccreate(output_file,"/CalibratedSceneTemperatures/tb165", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/tb165",rad.TB.data(:,2))

nccreate(output_file,"/CalibratedSceneTemperatures/tb176", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/tb176",rad.TB.data(:,3))

nccreate(output_file,"/CalibratedSceneTemperatures/tb180", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/tb180",rad.TB.data(:,4))

nccreate(output_file,"/CalibratedSceneTemperatures/tb182", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/tb182",rad.TB.data(:,5))

nccreate(output_file,"/CalibratedSceneTemperatures/tb89", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/tb89",rad.TB.data(:,1))

nccreate(output_file,"/CalibrationData/cal_cs_adc_mean","Dimensions",{"Ncal",length(cal.adcCS_m.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/cal_cs_adc_mean",cal.adcCS_m.data)

nccreate(output_file,"/CalibrationData/cal_cs_adc_std","Dimensions",{"Ncal",length(cal.adcCS_s.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/cal_cs_adc_std",cal.adcCS_s.data)

nccreate(output_file,"/CalibrationData/cal_cs_temp","Dimensions",{"Ncal",length(cal.TcalCS_m.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/cal_cs_temp",cal.TcalCS_m.data) % check if this works

nccreate(output_file,"/CalibrationData/cal_gain","Dimensions",{"Ncal",length(cal.gain.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/cal_gain",cal.gain.data)

nccreate(output_file,"/CalibrationData/cal_scan_flag","Dimensions",{"Ncal",length(cal.flagRegister.data)},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/cal_scan_flag",cal.flagRegister.data)

nccreate(output_file,"/CalibrationData/cal_time_string","Dimensions",{"Ncal",length(cal.cal_cs_adc_mean.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/cal_time_string",cal.cal_time_string.data)

nccreate(output_file,"/CalibrationData/cal_time_tai93","Dimensions",{"Ncal",length(cal.cal_cs_adc_mean.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/cal_time_tai93",cal.cal_time_tai93.data)

nccreate(output_file,"/CalibrationData/cal_wl_adc_mean","Dimensions",{"Ncal",length(cal.cal_cs_adc_mean.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/cal_wl_adc_mean",cal.cal_wl_adc_mean.data)

nccreate(output_file,"/CalibrationData/cal_wl_adc_mean","Dimensions",{"Ncal",length(cal.cal_cs_adc_mean.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/cal_wl_adc_mean",cal.cal_wl_adc_mean.data)

nccreate(output_file,"/CalibrationData/cal_wl_adc_std","Dimensions",{"Ncal",length(cal.cal_cs_adc_mean.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/cal_wl_adc_std",cal.cal_wl_adc_std.data)

nccreate(output_file,"/CalibrationData/cal_wl_temp","Dimensions",{"Ncal",length(cal.cal_cs_adc_mean.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/cal_wl_temp",cal.cal_wl_temp.data)

nccreate(output_file,"/Geolocation/att_source_flag", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/att_source_flag",sc.att_source_flag.data)

nccreate(output_file,"/Geolocation/earth_az_ang", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/earth_az_ang",rad.earth_az_ang.data)

nccreate(output_file,"/Geolocation/earth_inc_ang", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/earth_inc_ang",rad.binc.data)

nccreate(output_file,"/Geolocation/earth_pol_rot", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/earth_pol_rot",rad.potrot.data)

nccreate(output_file,"/Geolocation/eph_source_flag", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/eph_source_flag",rad.eph_source_flag.data)

nccreate(output_file,"/Geolocation/inst_boresight_ecr", "Dimensions",{"v",3,"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/inst_boresight_ecr",rad.inst_boresight_ecr.data)

nccreate(output_file,"/Geolocation/inst_scan_ang", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/inst_scan_ang",rad.scanang.data)

nccreate(output_file,"/Geolocation/obs_lat", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/obs_lat",rad.blat.data)

nccreate(output_file,"/Geolocation/obs_lon", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/obs_lon",rad.obs_lon.data)

nccreate(output_file,"/Geolocation/sat_alt", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_alt",rad.SCalt.data)

nccreate(output_file,"/Geolocation/sat_caa", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_caa",rad.caa.data)

nccreate(output_file,"/Geolocation/sat_lat", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_lat",rad.SClat.data)

nccreate(output_file,"/Geolocation/sat_lon", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_lon",rad.SClon.data)

nccreate(output_file,"/Geolocation/sat_lunar_az", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_lunar_az",rad.sat_lunar_az.data)

nccreate(output_file,"/Geolocation/sat_lunar_zen", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_lunar_zen",rad.sat_lunar_zen.data)

nccreate(output_file,"/Geolocation/sat_pitch", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_pitch",rad.SCpitch.data)

nccreate(output_file,"/Geolocation/sat_pos_eci", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_pos_eci",rad.sat_pos_eci.data)

nccreate(output_file,"/Geolocation/sat_pos_ecr", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_pos_ecr",rad.sat_pos_ecr.data)

nccreate(output_file,"/Geolocation/sat_roll", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_roll",rad.SCroll.data)

nccreate(output_file,"/Geolocation/sat_solar_az", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_solar_az",rad.sat_solar_az.data)

nccreate(output_file,"/Geolocation/sat_solar_zen", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_solar_zen",rad.sat_solar_zen.data)

nccreate(output_file,"/Geolocation/sat_vel_eci", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_vel_eci",rad.sat_vel_eci.data)

nccreate(output_file,"/Geolocation/sat_vel_ecr", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_vel_ecr",rad.sat_vel_ecr.data)

nccreate(output_file,"/Geolocation/sat_yaw", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_yaw",rad.sat_yaw.data)

nccreate(output_file,"/Geolocation/sc_scan_ang", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sc_scan_ang",rad.sc_scan_ang.data)

nccreate(output_file,"/Geolocation/sun_glint_ang", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sun_glint_ang",rad.sun_glint_ang.data)

nccreate(output_file,"/Geolocation/instr_roll", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/instr_roll",rad.instr_roll.data)

nccreate(output_file,"/Geolocation/instr_pitch", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/instr_pitch",rad.instr_pitch.data)

nccreate(output_file,"/Geolocation/instr_yaw", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/instr_yaw",rad.instr_yaw.data)

nccreate(output_file,"/Geolocation/time_string", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/time_string",rad.time_string.data)

nccreate(output_file,"/Geolocation/time_tai93", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/time_tai93",rad.time_tai93.data)

nccreate(output_file,"/InstrumentTemperatures/temp_cal1", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/InstrumentTemperatures/temp_cal1",rad.temp_cal1.data)

nccreate(output_file,"/InstrumentTemperatures/temp_cal2", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/InstrumentTemperatures/temp_cal2",rad.temp_cal2.data)

nccreate(output_file,"/InstrumentTemperatures/temp_cal3", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/InstrumentTemperatures/temp_cal3",rad.temp_cal3.data)

nccreate(output_file,"/InstrumentTemperatures/temp_fe_wr10", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/InstrumentTemperatures/temp_fe_wr10",rad.temp_fe_wr10.data)

nccreate(output_file,"/InstrumentTemperatures/temp_fe_wr5", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/InstrumentTemperatures/temp_fe_wr5",rad.temp_fe_wr5.data)

nccreate(output_file,"/InstrumentTemperatures/temp_pdiv_wr5", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/InstrumentTemperatures/temp_pdiv_wr5",rad.temp_pdiv_wr5.data)

nccreate(output_file,"/SinglePointCal/sp_cs_ta165", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_cs_ta165",rad.sp_cs_ta165.data)

nccreate(output_file,"/SinglePointCal/sp_cs_ta176", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_cs_ta176",rad.sp_cs_ta176.data)

nccreate(output_file,"/SinglePointCal/sp_cs_ta180", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_cs_ta180",rad.sp_cs_ta180.data)

nccreate(output_file,"/SinglePointCal/sp_cs_ta182", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_cs_ta182",rad.sp_cs_ta182.data)

nccreate(output_file,"/SinglePointCal/sp_cs_ta89", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_cs_ta89",rad.sp_cs_ta89.data)

nccreate(output_file,"/SinglePointCal/sp_wl_ta165", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_wl_ta165",rad.sp_wl_ta165.data)

nccreate(output_file,"/SinglePointCal/sp_wl_ta176", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_wl_ta176",rad.sp_wl_ta176.data)

nccreate(output_file,"/SinglePointCal/sp_wl_ta180", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_wl_ta180",rad.sp_wl_ta180.data)

nccreate(output_file,"/SinglePointCal/sp_wl_ta182", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_wl_ta182",rad.sp_wl_ta182.data)

nccreate(output_file,"/SinglePointCal/sp_wl_ta89", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_wl_ta89",rad.sp_wl_ta89.data)

nccreate(output_file,"/TwoPointCal/tp_ta165", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/TwoPointCal/tp_ta165",rad.tp_ta165.data)

nccreate(output_file,"/TwoPointCal/tp_ta176", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/TwoPointCal/tp_ta176",rad.tp_ta176.data)

nccreate(output_file,"/TwoPointCal/tp_ta180", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/TwoPointCal/tp_ta180",rad.tp_ta180.data)

nccreate(output_file,"/TwoPointCal/tp_ta182", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/TwoPointCal/tp_ta182",rad.tp_ta182.data)

nccreate(output_file,"/TwoPointCal/tp_ta89", "Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/tp_ta89",rad.tp_ta89.data)


