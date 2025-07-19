%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% process_inst_data.m
%
% This script processing housekeeping data on observation time points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function inst = process_inst_data(inst,d)
% initialize
inst.temp_cal1.data = NaN(size(d.s.TIMESTAMP));
inst.temp_cal2.data = NaN(size(d.s.TIMESTAMP));
inst.temp_cal3.data = NaN(size(d.s.TIMESTAMP));
inst.temp_fe_wr10.data = NaN(size(d.s.TIMESTAMP));
inst.temp_fe_wr5.data = NaN(size(d.s.TIMESTAMP));
inst.temp_pdiv_wr5.data = NaN(size(d.s.TIMESTAMP));

% interpolate
inst.temp_cal1.data = interp1(d.h.TIMESTAMP,d.h.THERM_COUNT0,d.s.TIMESTAMP,'nearest','extrap');
inst.temp_cal2.data = interp1(d.h.TIMESTAMP,d.h.THERM_COUNT1,d.s.TIMESTAMP,'nearest','extrap');
inst.temp_cal3.data = interp1(d.h.TIMESTAMP,d.h.THERM_COUNT2,d.s.TIMESTAMP,'nearest','extrap');
inst.temp_fe_wr10.data = interp1(d.h.TIMESTAMP,d.h.THERM_COUNT5,d.s.TIMESTAMP,'nearest','extrap');
inst.temp_fe_wr5.data = interp1(d.h.TIMESTAMP,d.h.THERM_COUNT4,d.s.TIMESTAMP,'nearest','extrap');
inst.temp_pdiv_wr5.data = interp1(d.h.TIMESTAMP,d.h.THERM_COUNT3,d.s.TIMESTAMP,'nearest','extrap');

end