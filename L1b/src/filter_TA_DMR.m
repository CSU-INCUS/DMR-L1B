function rad = filter_TA_DMR(c,rad)

for ch = 1:5
    % two point
    ind = find(rad.TA_tp.data(:,ch) < c.minTA_qc | rad.TA_tp.data(:,ch) > c.maxTA_qc | rad.SCinc.data > c.SCinc_max);
    rad.TA_tp.data(ind,ch) = c.fill_val;

    % single point warm load
    ind = find(rad.TA_spWL.data(:,ch) < c.minTA_qc | rad.TA_spWL.data(:,ch) > c.maxTA_qc | rad.SCinc.data > c.SCinc_max);
    rad.TA_spWL.data(ind,ch) = c.fill_val;

    % single point cold sky
    ind = find(rad.TA_spCS.data(:,ch) < c.minTA_qc | rad.TA_spCS.data(:,ch) > c.maxTA_qc | rad.SCinc.data > c.SCinc_max);
    rad.TA_spCS.data(ind,ch) = c.fill_val;
end

rad.TA_tp.data=real(rad.TA_tp.data);
rad.TA_spWL.data=real(rad.TA_spWL.data);
rad.TA_spCS.data=real(rad.TA_spCS.data);
