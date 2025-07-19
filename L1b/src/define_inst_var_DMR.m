function inst = define_inst_var_DMR(d)

inst.temp_cal1.data = zeros(length(d.s.TIMESTAMP),1);
inst.temp_cal1.longname = 'Measured temperature for calibration target 1';
inst.temp_cal1.units = 'K';

inst.temp_cal2.data = zeros(length(d.s.TIMESTAMP),1);
inst.temp_cal2.longname = 'Measured temperature for calibration target 2';
inst.temp_cal2.units = 'K';

inst.temp_cal3.data = zeros(length(d.s.TIMESTAMP),1);
inst.temp_cal3.longname = 'Measured temperature for calibration target 3';
inst.temp_cal3.units = 'K';

inst.temp_fe_wr10.data = zeros(length(d.s.TIMESTAMP),1);
inst.temp_fe_wr10.longname = 'Measured temperature for WR10 front-end';
inst.temp_fe_wr10.units = 'K';

inst.temp_fe_wr5.data = zeros(length(d.s.TIMESTAMP),1);
inst.temp_fe_wr5.longname = 'Measured temperature for WR5 front-end';
inst.temp_fe_wr5.units = 'K';

inst.temp_pdiv_wr5.data = zeros(length(d.s.TIMESTAMP),1);
inst.temp_pdiv_wr5.longname = 'Measured temperature for WR5 power divider';
inst.temp_pdiv_wr5.units = 'K';

end