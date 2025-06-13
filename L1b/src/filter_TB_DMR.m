function rad = filter_TB_DMR(c,rad)

for ch = 1:5
    % two point
    ind = find(rad.TB.data(:,ch) < c.minTA_qc | rad.TB.data(:,ch) > c.maxTA_qc | rad.SCinc.data > c.SCinc_max);
    rad.TB.data(ind,ch) = c.fill_val;

    % single point warm load
    ind = find(rad.TB_spWL.data(:,ch) < c.minTA_qc | rad.TB_spWL.data(:,ch) > c.maxTA_qc | rad.SCinc.data > c.SCinc_max);
    rad.TB_spWL.data(ind,ch) = c.fill_val;

    % single point cold sky
    ind = find(rad.TB_spCS.data(:,ch) < c.minTA_qc | rad.TB_spCS.data(:,ch) > c.maxTA_qc | rad.SCinc.data > c.SCinc_max);
    rad.TB_spCS.data(ind,ch) = c.fill_val;
end

rad.TB.data=real(rad.TB.data);
rad.TB_spWL.data=real(rad.TB_spWL.data);
rad.TB_spCS.data=real(rad.TB_spCS.data);
