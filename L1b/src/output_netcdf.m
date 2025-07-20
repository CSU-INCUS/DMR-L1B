function output_netcdf(d,inst,rad,cal,sc,output_file)

nccreate(output_file,"/Ancillary/obs_land_flag","DataType","int8","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Ancillary/obs_land_flag",int8(rad.landmask.data))
ncwriteatt(output_file,"/Ancillary/obs_land_flag","Units",rad.landmask.units)
ncwriteatt(output_file,"/Ancillary/obs_land_flag","Longname",rad.landmask.longname)

nccreate(output_file,"/Ancillary/scene_flag","DataType","int8","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Ancillary/scene_flag",int8(rad.scene.data))
ncwriteatt(output_file,"/Ancillary/scene_flag","Units",rad.scene.units)
ncwriteatt(output_file,"/Ancillary/scene_flag","Longname",rad.scene.longname)

nccreate(output_file,"/Ancillary/asds","DataType","int8","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Ancillary/asds",int8(rad.asds.data))
ncwriteatt(output_file,"/Ancillary/asds","Units",rad.asds.units)
ncwriteatt(output_file,"/Ancillary/asds","Longname",rad.asds.longname)

nccreate(output_file,"/CalibratedSceneTemperatures/earth_inc_flag","DataType","int8","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/earth_inc_flag",int8(rad.earth_inc_flag.data))
ncwriteatt(output_file,"/CalibratedSceneTemperatures/earth_inc_flag","Units",rad.earth_inc_flag.units)
ncwriteatt(output_file,"/CalibratedSceneTemperatures/earth_inc_flag","Longname",rad.earth_inc_flag.longname)

nccreate(output_file,"/CalibratedSceneTemperatures/trx","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/trx",single(rad.trx.data))
ncwriteatt(output_file,"/CalibratedSceneTemperatures/trx","Units",rad.trx.units)
ncwriteatt(output_file,"/CalibratedSceneTemperatures/trx","Longname",rad.trx.longname)

nccreate(output_file,"/CalibratedSceneTemperatures/obs_qual_flag","DataType","int8","Dimensions",{"Nobs",length(rad.landmask.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/obs_qual_flag",int8(rad.obs_qual_flag.data))
ncwriteatt(output_file,"/CalibratedSceneTemperatures/obs_qual_flag","Units",rad.obs_qual_flag.units)
ncwriteatt(output_file,"/CalibratedSceneTemperatures/obs_qual_flag","Longname",rad.trx.longname)

nccreate(output_file,"/CalibratedSceneTemperatures/tb165","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/tb165",single(rad.TB.data(:,2)))
ncwriteatt(output_file,"/CalibratedSceneTemperatures/tb165","Units",rad.TB.units)
ncwriteatt(output_file,"/CalibratedSceneTemperatures/tb165","Longname",rad.TB.longname)

nccreate(output_file,"/CalibratedSceneTemperatures/tb176","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/tb176",single(rad.TB.data(:,3)))
ncwriteatt(output_file,"/CalibratedSceneTemperatures/tb176","Units",rad.TB.units)
ncwriteatt(output_file,"/CalibratedSceneTemperatures/tb176","Longname",rad.TB.longname)

nccreate(output_file,"/CalibratedSceneTemperatures/tb180","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/tb180",single(rad.TB.data(:,4)))
ncwriteatt(output_file,"/CalibratedSceneTemperatures/tb180","Units",rad.TB.units)
ncwriteatt(output_file,"/CalibratedSceneTemperatures/tb180","Longname",rad.TB.longname)

nccreate(output_file,"/CalibratedSceneTemperatures/tb182","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/tb182",single(rad.TB.data(:,5)))
ncwriteatt(output_file,"/CalibratedSceneTemperatures/tb182","Units",rad.TB.units)
ncwriteatt(output_file,"/CalibratedSceneTemperatures/tb182","Longname",rad.TB.longname)

nccreate(output_file,"/CalibratedSceneTemperatures/tb89","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/CalibratedSceneTemperatures/tb89",single(rad.TB.data(:,1)))
ncwriteatt(output_file,"/CalibratedSceneTemperatures/tb89","Units",rad.TB.units)
ncwriteatt(output_file,"/CalibratedSceneTemperatures/tb89","Longname",rad.TB.longname)

nccreate(output_file,"/CalibrationData/cal_cs_adc_mean","DataType","single","Dimensions",{"Ncal",length(cal.adcCS_m.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/cal_cs_adc_mean",single(cal.adcCS_m.data))
ncwriteatt(output_file,"/CalibrationData/cal_cs_adc_mean","Units",cal.adcCS_m.units)
ncwriteatt(output_file,"/CalibrationData/cal_cs_adc_mean","Longname",cal.adcCS_m.longname)

nccreate(output_file,"/CalibrationData/cal_cs_adc_std","DataType","single","Dimensions",{"Ncal",length(cal.adcCS_s.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/cal_cs_adc_std",single(cal.adcCS_s.data))
ncwriteatt(output_file,"/CalibrationData/cal_cs_adc_std","Units",cal.adcCS_s.units)
ncwriteatt(output_file,"/CalibrationData/cal_cs_adc_std","Longname",cal.adcCS_s.longname)

nccreate(output_file,"/CalibrationData/cal_cs_temp","DataType","single","Dimensions",{"Ncal",length(cal.TcalCS_m.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/cal_cs_temp",single(cal.TcalCS_m.data)) 
ncwriteatt(output_file,"/CalibrationData/cal_cs_temp","Units",cal.TcalCS_m.units)
ncwriteatt(output_file,"/CalibrationData/cal_cs_temp","Longname",cal.TcalCS_m.longname)

nccreate(output_file,"/CalibrationData/cal_gain","DataType","single","Dimensions",{"Ncal",length(cal.gain.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/cal_gain",single(cal.gain.data))
ncwriteatt(output_file,"/CalibrationData/cal_gain","Units",cal.TcalCS_m.units)
ncwriteatt(output_file,"/CalibrationData/cal_gain","Longname",cal.TcalCS_m.longname)

nccreate(output_file,"/CalibrationData/NEDTwl","DataType","single","Dimensions",{"Ncal",length(cal.NEDTwl.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/NEDTwl",single(cal.NEDTwl.data))
ncwriteatt(output_file,"/CalibrationData/NEDTwl","Units",cal.NEDTwl.units)
ncwriteatt(output_file,"/CalibrationData/NEDTwl","Longname",cal.NEDTwl.longname)

nccreate(output_file,"/CalibrationData/NEDTcs","DataType","single","Dimensions",{"Ncal",length(cal.NEDTcs.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/NEDTcs",single(cal.NEDTcs.data))
ncwriteatt(output_file,"/CalibrationData/NEDTcs","Units",cal.NEDTcs.units)
ncwriteatt(output_file,"/CalibrationData/NEDTcs","Longname",cal.NEDTcs.longname)

nccreate(output_file,"/CalibrationData/num_wl_obs","DataType","single","Dimensions",{"Ncal",length(cal.num_wl_obs.data)},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/num_wl_obs",single(cal.num_wl_obs.data))
ncwriteatt(output_file,"/CalibrationData/num_wl_obs","Units",cal.num_wl_obs.units)
ncwriteatt(output_file,"/CalibrationData/num_wl_obs","Longname",cal.num_wl_obs.longname)

nccreate(output_file,"/CalibrationData/num_cs_obs","DataType","single","Dimensions",{"Ncal",length(cal.num_wl_obs.data)},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/num_cs_obs",single(cal.num_cs_obs.data))
ncwriteatt(output_file,"/CalibrationData/num_cs_obs","Units",cal.num_cs_obs.units)
ncwriteatt(output_file,"/CalibrationData/num_cs_obs","Longname",cal.num_cs_obs.longname)

nccreate(output_file,"/CalibrationData/cal_time","DataType","single","Dimensions",{"Ncal",length(cal.num_wl_obs.data)},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/cal_time",single(cal.time.data))
ncwriteatt(output_file,"/CalibrationData/cal_time","Units",cal.time.units)
ncwriteatt(output_file,"/CalibrationData/cal_time","Longname",cal.time.longname)

nccreate(output_file,"/CalibrationData/cal_wl_adc_mean","DataType","single","Dimensions",{"Ncal",length(cal.adcWL_m.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/cal_wl_adc_mean",single(cal.adcWL_m.data))
ncwriteatt(output_file,"/CalibrationData/cal_wl_adc_mean","Units",cal.adcWL_m.units)
ncwriteatt(output_file,"/CalibrationData/cal_wl_adc_mean","Longname",cal.adcWL_m.longname)

nccreate(output_file,"/CalibrationData/cal_wl_adc_std","DataType","single","Dimensions",{"Ncal",length(cal.adcWL_s.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/cal_wl_adc_std",single(cal.adcWL_s.data))
ncwriteatt(output_file,"/CalibrationData/cal_wl_adc_std","Units",cal.adcWL_s.units)
ncwriteatt(output_file,"/CalibrationData/cal_wl_adc_std","Longname",cal.adcWL_s.longname)

nccreate(output_file,"/CalibrationData/cal_wl_temp","DataType","single","Dimensions",{"Ncal",length(cal.TcalWL_m.data),"ch",5},"Format","netcdf4")
ncwrite(output_file,"/CalibrationData/cal_wl_temp",single(cal.TcalWL_m.data))
ncwriteatt(output_file,"/CalibrationData/cal_wl_temp","Units",cal.adcWL_s.units)
ncwriteatt(output_file,"/CalibrationData/cal_wl_temp","Longname",cal.adcWL_s.longname)

nccreate(output_file,"/Geolocation/earth_inc_ang","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/earth_inc_ang",single(rad.binc.data))
ncwriteatt(output_file,"/Geolocation/earth_inc_ang","Units",rad.binc.units)
ncwriteatt(output_file,"/Geolocation/earth_inc_ang","Longname",rad.binc.longname)

nccreate(output_file,"/Geolocation/inst_scan_ang","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/inst_scan_ang",single(rad.scanang.data))
ncwriteatt(output_file,"/Geolocation/inst_scan_ang","Units",rad.scanang.units)
ncwriteatt(output_file,"/Geolocation/inst_scan_ang","Longname",rad.scanang.longname)

nccreate(output_file,"/Geolocation/obs_lat","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/obs_lat",single(rad.blat.data))
ncwriteatt(output_file,"/Geolocation/obs_lat","Units",rad.blat.units)
ncwriteatt(output_file,"/Geolocation/obs_lat","Longname",rad.blat.longname)

nccreate(output_file,"/Geolocation/obs_lon","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/obs_lon",single(rad.blon.data))
ncwriteatt(output_file,"/Geolocation/obs_lon","Units",rad.blon.units)
ncwriteatt(output_file,"/Geolocation/obs_lon","Longname",rad.blon.longname)

nccreate(output_file,"/Geolocation/sat_alt","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_alt",single(rad.SCalt.data))
ncwriteatt(output_file,"/Geolocation/sat_alt","Units",rad.SCalt.units)
ncwriteatt(output_file,"/Geolocation/sat_alt","Longname",rad.SCalt.longname)

nccreate(output_file,"/Geolocation/sat_lat","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_lat",single(rad.SClat.data))
ncwriteatt(output_file,"/Geolocation/sat_lat","Units",rad.SClat.units)
ncwriteatt(output_file,"/Geolocation/sat_lat","Longname",rad.SClat.longname)

nccreate(output_file,"/Geolocation/sat_lon","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_lon",single(rad.SClon.data))
ncwriteatt(output_file,"/Geolocation/sat_lon","Units",rad.SClon.units)
ncwriteatt(output_file,"/Geolocation/sat_lon","Longname",rad.SClon.longname)

nccreate(output_file,"/Geolocation/sat_pitch","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_pitch",single(rad.SCpitch.data))
ncwriteatt(output_file,"/Geolocation/sat_pitch","Units",rad.SCpitch.units)
ncwriteatt(output_file,"/Geolocation/sat_pitch","Longname",rad.SCpitch.longname)

nccreate(output_file,"/Geolocation/sat_roll","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_roll",single(rad.SCroll.data))
ncwriteatt(output_file,"/Geolocation/sat_roll","Units",rad.SCroll.units)
ncwriteatt(output_file,"/Geolocation/sat_roll","Longname",rad.SCroll.longname)

nccreate(output_file,"/Geolocation/sat_yaw","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/sat_yaw",single(rad.SCyaw.data))
ncwriteatt(output_file,"/Geolocation/sat_yaw","Units",rad.SCyaw.units)
ncwriteatt(output_file,"/Geolocation/sat_yaw","Longname",rad.SCyaw.longname)

nccreate(output_file,"/Geolocation/obs_time","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/Geolocation/obs_time",single(d.s.TIMESTAMP))
ncwriteatt(output_file,"/Geolocation/obs_time","Units",'s')
ncwriteatt(output_file,"/Geolocation/obs_time","Longname",'Time at capture, seconds since J2000')

nccreate(output_file,"/InstrumentTemperatures/temp_cal1","DataType","single","Dimensions",{"Nobs",length(inst.temp_cal1.data)},"Format","netcdf4")
ncwrite(output_file,"/InstrumentTemperatures/temp_cal1",single(inst.temp_cal1.data))
ncwriteatt(output_file,"/InstrumentTemperatures/temp_cal1","Units",inst.temp_cal1.units)
ncwriteatt(output_file,"/InstrumentTemperatures/temp_cal1","Longname",inst.temp_cal1.longname)

nccreate(output_file,"/InstrumentTemperatures/temp_cal2","DataType","single","Dimensions",{"Nobs",length(inst.temp_cal2.data)},"Format","netcdf4")
ncwrite(output_file,"/InstrumentTemperatures/temp_cal2",single(inst.temp_cal2.data))
ncwriteatt(output_file,"/InstrumentTemperatures/temp_cal2","Units",inst.temp_cal2.units)
ncwriteatt(output_file,"/InstrumentTemperatures/temp_cal2","Longname",inst.temp_cal2.longname)

nccreate(output_file,"/InstrumentTemperatures/temp_cal3","DataType","single","Dimensions",{"Nobs",length(inst.temp_cal3.data)},"Format","netcdf4")
ncwrite(output_file,"/InstrumentTemperatures/temp_cal3",single(inst.temp_cal3.data))
ncwriteatt(output_file,"/InstrumentTemperatures/temp_cal3","Units",inst.temp_cal3.units)
ncwriteatt(output_file,"/InstrumentTemperatures/temp_cal3","Longname",inst.temp_cal3.longname)

nccreate(output_file,"/InstrumentTemperatures/temp_fe_wr10","DataType","single","Dimensions",{"Nobs",length(inst.temp_fe_wr10.data)},"Format","netcdf4")
ncwrite(output_file,"/InstrumentTemperatures/temp_fe_wr10",single(inst.temp_fe_wr10.data))
ncwriteatt(output_file,"/InstrumentTemperatures/temp_fe_wr10","Units",inst.temp_fe_wr10.units)
ncwriteatt(output_file,"/InstrumentTemperatures/temp_fe_wr10","Longname",inst.temp_fe_wr10.longname)

nccreate(output_file,"/InstrumentTemperatures/temp_fe_wr5","DataType","single","Dimensions",{"Nobs",length(inst.temp_fe_wr5.data)},"Format","netcdf4")
ncwrite(output_file,"/InstrumentTemperatures/temp_fe_wr5",single(inst.temp_fe_wr5.data))
ncwriteatt(output_file,"/InstrumentTemperatures/temp_fe_wr5","Units",inst.temp_fe_wr5.units)
ncwriteatt(output_file,"/InstrumentTemperatures/temp_fe_wr5","Longname",inst.temp_fe_wr5.longname)

nccreate(output_file,"/InstrumentTemperatures/temp_pdiv_wr5","DataType","single","Dimensions",{"Nobs",length(inst.temp_pdiv_wr5.data)},"Format","netcdf4")
ncwrite(output_file,"/InstrumentTemperatures/temp_pdiv_wr5",single(inst.temp_pdiv_wr5.data))
ncwriteatt(output_file,"/InstrumentTemperatures/temp_pdiv_wr5","Units",inst.temp_pdiv_wr5.units)
ncwriteatt(output_file,"/InstrumentTemperatures/temp_pdiv_wr5","Longname",inst.temp_pdiv_wr5.longname)

nccreate(output_file,"/SinglePointCal/sp_cs_ta165","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_cs_ta165",single(rad.TA_spCS.data(:,2)))
ncwriteatt(output_file,"/SinglePointCal/sp_cs_ta165","Units",rad.TA_spCS.units)
ncwriteatt(output_file,"/SinglePointCal/sp_cs_ta165","Longname",rad.TA_spCS.longname)

nccreate(output_file,"/SinglePointCal/sp_cs_ta176","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_cs_ta176",single(rad.TA_spCS.data(:,3)))
ncwriteatt(output_file,"/SinglePointCal/sp_cs_ta176","Units",rad.TA_spCS.units)
ncwriteatt(output_file,"/SinglePointCal/sp_cs_ta176","Longname",rad.TA_spCS.longname)

nccreate(output_file,"/SinglePointCal/sp_cs_ta180","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_cs_ta180",single(rad.TA_spCS.data(:,4)))
ncwriteatt(output_file,"/SinglePointCal/sp_cs_ta180","Units",rad.TA_spCS.units)
ncwriteatt(output_file,"/SinglePointCal/sp_cs_ta180","Longname",rad.TA_spCS.longname)

nccreate(output_file,"/SinglePointCal/sp_cs_ta182","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_cs_ta182",single(rad.TA_spCS.data(:,5)))
ncwriteatt(output_file,"/SinglePointCal/sp_cs_ta182","Units",rad.TA_spCS.units)
ncwriteatt(output_file,"/SinglePointCal/sp_cs_ta182","Longname",rad.TA_spCS.longname)

nccreate(output_file,"/SinglePointCal/sp_cs_ta89","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_cs_ta89",single(rad.TA_spCS.data(:,1)))
ncwriteatt(output_file,"/SinglePointCal/sp_cs_ta89","Units",rad.TA_spCS.units)
ncwriteatt(output_file,"/SinglePointCal/sp_cs_ta89","Longname",rad.TA_spCS.longname)

nccreate(output_file,"/SinglePointCal/sp_wl_ta165","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_wl_ta165",single(rad.TA_spWL.data(:,2)))
ncwriteatt(output_file,"/SinglePointCal/sp_wl_ta165","Units",rad.TA_spWL.units)
ncwriteatt(output_file,"/SinglePointCal/sp_wl_ta165","Longname",rad.TA_spWL.longname)

nccreate(output_file,"/SinglePointCal/sp_wl_ta176","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_wl_ta176",single(rad.TA_spWL.data(:,3)))
ncwriteatt(output_file,"/SinglePointCal/sp_wl_ta176","Units",rad.TA_spWL.units)
ncwriteatt(output_file,"/SinglePointCal/sp_wl_ta176","Longname",rad.TA_spWL.longname)

nccreate(output_file,"/SinglePointCal/sp_wl_ta180","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_wl_ta180",single(rad.TA_spWL.data(:,4)))
ncwriteatt(output_file,"/SinglePointCal/sp_wl_ta180","Units",rad.TA_spWL.units)
ncwriteatt(output_file,"/SinglePointCal/sp_wl_ta180","Longname",rad.TA_spWL.longname)

nccreate(output_file,"/SinglePointCal/sp_wl_ta182","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_wl_ta182",single(rad.TA_spWL.data(:,5)))
ncwriteatt(output_file,"/SinglePointCal/sp_wl_ta182","Units",rad.TA_spWL.units)
ncwriteatt(output_file,"/SinglePointCal/sp_wl_ta182","Longname",rad.TA_spWL.longname)

nccreate(output_file,"/SinglePointCal/sp_wl_ta89","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/SinglePointCal/sp_wl_ta89",single(rad.TA_spWL.data(:,1)))
ncwriteatt(output_file,"/SinglePointCal/sp_wl_ta89","Units",rad.TA_spWL.units)
ncwriteatt(output_file,"/SinglePointCal/sp_wl_ta89","Longname",rad.TA_spWL.longname)

nccreate(output_file,"/TwoPointCal/tp_ta165","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/TwoPointCal/tp_ta165",single(rad.TA_tp.data(:,2)))
ncwriteatt(output_file,"/TwoPointCal/tp_ta165","Units",rad.TA_tp.units)
ncwriteatt(output_file,"/TwoPointCal/tp_ta165","Longname",rad.TA_tp.longname)

nccreate(output_file,"/TwoPointCal/tp_ta176","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/TwoPointCal/tp_ta176",single(rad.TA_tp.data(:,3)))
ncwriteatt(output_file,"/TwoPointCal/tp_ta176","Units",rad.TA_tp.units)
ncwriteatt(output_file,"/TwoPointCal/tp_ta176","Longname",rad.TA_tp.longname)

nccreate(output_file,"/TwoPointCal/tp_ta180","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/TwoPointCal/tp_ta180",single(rad.TA_tp.data(:,4)))
ncwriteatt(output_file,"/TwoPointCal/tp_ta180","Units",rad.TA_tp.units)
ncwriteatt(output_file,"/TwoPointCal/tp_ta180","Longname",rad.TA_tp.longname)

nccreate(output_file,"/TwoPointCal/tp_ta182","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/TwoPointCal/tp_ta182",single(rad.TA_tp.data(:,5)))
ncwriteatt(output_file,"/TwoPointCal/tp_ta182","Units",rad.TA_tp.units)
ncwriteatt(output_file,"/TwoPointCal/tp_ta182","Longname",rad.TA_tp.longname)

nccreate(output_file,"/TwoPointCal/tp_ta89","DataType","single","Dimensions",{"Nobs",length(rad.landmask.data)},"Format","netcdf4")
ncwrite(output_file,"/TwoPointCal/tp_ta89",single(rad.TA_tp.data(:,1)))
ncwriteatt(output_file,"/TwoPointCal/tp_ta89","Units",rad.TA_tp.units)
ncwriteatt(output_file,"/TwoPointCal/tp_ta89","Longname",rad.TA_tp.longname)



