function output_netcdf(rad,cal,sc,output_file)

nccreate(output_file,"/Ancillary/obs_land_flag", "Dimensions",{"Nobs",length(rad.obs_land_flag.data)},"Format","netcdf4")
ncwrite(output_file,"/Ancillary/obs_land_flag",obs_land_flag.data)

nccreate(output_file,"/CalibratedSceneTemperatures/earth_inc_flag", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/earth_inc_flag",earth_inc_flag.data)

nccreate(output_file,"/CalibratedSceneTemperatures/obs_qual_flag", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/obs_qual_flag",obs_qual_flag.data)

nccreate(output_file,"/CalibratedSceneTemperatures/tb165", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/tb165",tb165.data)

nccreate(output_file,"/CalibratedSceneTemperatures/tb176", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/tb176",tb176.data)

nccreate(output_file,"/CalibratedSceneTemperatures/tb180", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/tb180",tb180.data)

nccreate(output_file,"/CalibratedSceneTemperatures/tb182", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/tb182",tb182.data)

nccreate(output_file,"/CalibratedSceneTemperatures/tb89", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/tb89",tb89.data)

nccreate(staticFile,"/CalibrationData/cal_cs_adc_mean","Dimensions",{"Ncal",length(cal.cal_cs_adc_mean.data),"ch",5},"Format","netcdf4")
ncwrite(staticFile,"/CalibrationData/cal_cs_adc_mean",cal.cal_cs_adc_mean.data)

nccreate(staticFile,"/CalibrationData/cal_cs_adc_std","Dimensions","Ncal","ch","Format","netcdf4")
ncwrite(staticFile,"/CalibrationData/cal_cs_adc_std",cal.cal_cs_adc_std.data)

nccreate(staticFile,"/CalibrationData/cal_cs_temp","Dimensions","Ncal","ch","Format","netcdf4")
ncwrite(staticFile,"/CalibrationData/cal_cs_temp",cal.cal_cs_temp.data)

nccreate(staticFile,"/CalibrationData/cal_gain","Dimensions","Ncal","ch","Format","netcdf4")
ncwrite(staticFile,"/CalibrationData/cal_gain",cal.cal_gain.data)

nccreate(staticFile,"/CalibrationData/cal_scan_flag","Dimensions","Ncal","ch","Format","netcdf4")
ncwrite(staticFile,"/CalibrationData/cal_scan_flag",cal.cal_scan_flag.data)

nccreate(staticFile,"/CalibrationData/cal_time_string","Dimensions","Ncal","ch","Format","netcdf4")
ncwrite(staticFile,"/CalibrationData/cal_time_string",cal.cal_time_string.data)

nccreate(staticFile,"/CalibrationData/cal_time_tai93","Dimensions","Ncal","ch","Format","netcdf4")
ncwrite(staticFile,"/CalibrationData/cal_time_tai93",cal.cal_time_tai93.data)

nccreate(staticFile,"/CalibrationData/cal_wl_adc_mean","Dimensions","Ncal","ch","Format","netcdf4")
ncwrite(staticFile,"/CalibrationData/cal_wl_adc_mean",cal.cal_wl_adc_mean.data)

nccreate(staticFile,"/CalibrationData/cal_wl_adc_mean","Dimensions","Ncal","ch","Format","netcdf4")
ncwrite(staticFile,"/CalibrationData/cal_wl_adc_mean",cal.cal_wl_adc_mean.data)

nccreate(staticFile,"/CalibrationData/cal_wl_adc_std","Dimensions","Ncal","ch","Format","netcdf4")
ncwrite(staticFile,"/CalibrationData/cal_wl_adc_std",cal.cal_wl_adc_std.data)

nccreate(staticFile,"/CalibrationData/cal_wl_temp","Dimensions","Ncal","ch","Format","netcdf4")
ncwrite(staticFile,"/CalibrationData/cal_wl_temp",cal.cal_wl_temp.data)

nccreate(output_file,"/Geolocation/att_source_flag", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/att_source_flag",sc.att_source_flag.data)

nccreate(output_file,"/Geolocation/earth_az_ang", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/earth_az_ang",rad.earth_az_ang.data)

nccreate(output_file,"/Geolocation/earth_inc_ang", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/earth_inc_ang",rad.binc.data)

nccreate(output_file,"/Geolocation/earth_pol_rot", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/earth_pol_rot",rad.potrot.data)

nccreate(output_file,"/Geolocation/eph_source_flag", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/eph_source_flag",rad.eph_source_flag.data)

nccreate(output_file,"/Geolocation/inst_boresight_ecr", "Dimensions","v",3,"Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/inst_boresight_ecr",rad.inst_boresight_ecr.data)

nccreate(output_file,"/Geolocation/inst_scan_ang", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/inst_scan_ang",rad.scanang.data)

nccreate(output_file,"/Geolocation/obs_lat", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/obs_lat",rad.blat.data)

nccreate(output_file,"/Geolocation/obs_lon", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/obs_lon",rad.obs_lon.data)

nccreate(output_file,"/Geolocation/sat_alt", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_alt",rad.SCalt.data)

nccreate(output_file,"/Geolocation/sat_caa", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_caa",rad.caa.data)

nccreate(output_file,"/Geolocation/sat_lat", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_lat",rad.SClat.data)

nccreate(output_file,"/Geolocation/sat_lon", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_lon",rad.SClon.data)

nccreate(output_file,"/Geolocation/sat_lunar_az", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_lunar_az",rad.sat_lunar_az.data)

nccreate(output_file,"/Geolocation/sat_lunar_zen", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_lunar_zen",rad.sat_lunar_zen.data)

nccreate(output_file,"/Geolocation/sat_pitch", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_pitch",rad.SCpitch.data)

nccreate(output_file,"/Geolocation/sat_pos_eci", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_pos_eci",rad.sat_pos_eci.data)

nccreate(output_file,"/Geolocation/sat_pos_ecr", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_pos_ecr",rad.sat_pos_ecr.data)

nccreate(output_file,"/Geolocation/sat_roll", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_roll",rad.SCroll.data)

nccreate(output_file,"/Geolocation/sat_solar_az", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_solar_az",rad.sat_solar_az.data)

nccreate(output_file,"/Geolocation/sat_solar_zen", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_solar_zen",rad.sat_solar_zen.data)

nccreate(output_file,"/Geolocation/sat_vel_eci", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_vel_eci",rad.sat_vel_eci.data)

nccreate(output_file,"/Geolocation/sat_vel_ecr", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_vel_ecr",rad.sat_vel_ecr.data)

nccreate(output_file,"/Geolocation/sat_yaw", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_yaw",rad.sat_yaw.data)

nccreate(output_file,"/Geolocation/sc_scan_ang", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/sc_scan_ang",rad.sc_scan_ang.data)

nccreate(output_file,"/Geolocation/sun_glint_ang", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/sun_glint_ang",rad.sun_glint_ang.data)

nccreate(output_file,"/Geolocation/instr_roll", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/instr_roll",rad.instr_roll.data)

nccreate(output_file,"/Geolocation/instr_pitch", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/instr_pitch",rad.instr_pitch.data)

nccreate(output_file,"/Geolocation/instr_yaw", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/instr_yaw",rad.instr_yaw.data)

nccreate(output_file,"/Geolocation/time_string", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/time_string",rad.time_string.data)

nccreate(output_file,"/Geolocation/time_tai93", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/Geolocation/time_tai93",rad.time_tai93.data)

nccreate(output_file,"/InstrumentTemperatures/temp_cal1", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/InstrumentTemperatures/temp_cal1",rad.temp_cal1.data)

nccreate(output_file,"/InstrumentTemperatures/temp_cal2", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/InstrumentTemperatures/temp_cal2",rad.temp_cal2.data)

nccreate(output_file,"/InstrumentTemperatures/temp_cal3", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/InstrumentTemperatures/temp_cal3",rad.temp_cal3.data)

nccreate(output_file,"/InstrumentTemperatures/temp_fe_wr10", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/InstrumentTemperatures/temp_fe_wr10",rad.temp_fe_wr10.data)

nccreate(output_file,"/InstrumentTemperatures/temp_fe_wr5", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/InstrumentTemperatures/temp_fe_wr5",rad.temp_fe_wr5.data)

nccreate(output_file,"/InstrumentTemperatures/temp_pdiv_wr5", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/InstrumentTemperatures/temp_pdiv_wr5",rad.temp_pdiv_wr5.data)

nccreate(output_file,"/SinglePointCal/sp_cs_ta165", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_cs_ta165",rad.sp_cs_ta165.data)

nccreate(output_file,"/SinglePointCal/sp_cs_ta176", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_cs_ta176",rad.sp_cs_ta176.data)

nccreate(output_file,"/SinglePointCal/sp_cs_ta180", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_cs_ta180",rad.sp_cs_ta180.data)

nccreate(output_file,"/SinglePointCal/sp_cs_ta182", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_cs_ta182",rad.sp_cs_ta182.data)

nccreate(output_file,"/SinglePointCal/sp_cs_ta89", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_cs_ta89",rad.sp_cs_ta89.data)

nccreate(output_file,"/SinglePointCal/sp_wl_ta165", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_wl_ta165",rad.sp_wl_ta165.data)

nccreate(output_file,"/SinglePointCal/sp_wl_ta176", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_wl_ta176",rad.sp_wl_ta176.data)

nccreate(output_file,"/SinglePointCal/sp_wl_ta180", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_wl_ta180",rad.sp_wl_ta180.data)

nccreate(output_file,"/SinglePointCal/sp_wl_ta182", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_wl_ta182",rad.sp_wl_ta182.data)

nccreate(output_file,"/SinglePointCal/sp_wl_ta89", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_wl_ta89",rad.sp_wl_ta89.data)

nccreate(output_file,"/TwoPointCal/tp_ta165", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/TwoPointCal/tp_ta165",rad.tp_ta165.data)

nccreate(output_file,"/TwoPointCal/tp_ta176", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/TwoPointCal/tp_ta176",rad.tp_ta176.data)

nccreate(output_file,"/TwoPointCal/tp_ta180", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/TwoPointCal/tp_ta180",rad.tp_ta180.data)

nccreate(output_file,"/TwoPointCal/tp_ta182", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/TwoPointCal/tp_ta182",rad.tp_ta182.data)

nccreate(output_file,"/TwoPointCal/tp_ta89", "Dimensions","Nobs","Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/tp_ta89",rad.tp_ta89.data)


