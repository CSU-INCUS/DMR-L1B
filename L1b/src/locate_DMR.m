% based on tempestOlocate
function rad = locate_DMR(rad,sc,c)

% interpolate S/C sample rate to radiometer sample rate
rad.asds.data = interp1(sc.UTCtime.data, sc.asds.data, d.s.TIMESTAMP, 'nearest');
rad.SCyaw.data = interp1(sc.UTCtime.data, sc.yaw.data, d.s.TIMESTAMP, 'nearest'); 
rad.SCroll.data = interp1(sc.UTCtime.data, sc.roll.data, d.s.TIMESTAMP, 'nearest');  
rad.SCpitch.data = interp1(sc.UTCtime.data, sc.pitch.data, d.s.TIMESTAMP, 'nearest');  

ind = find(d.s.TIMESTAMP >= min(sc.UTCtime.data) & d.s.TIMESTAMP <= max(sc.UTCtime.data) & abs(rad.scanang.data) < c.max_scan_for_geo);

if (~isempty(ind))
    % interpolate S/C sample rate to radiometer sample rate
    ECI_rad = interp1(sc.UTCtime.data, sc.ECI.data, d.s.TIMESTAMP(ind), 'cubic'); 
    Q_ECI_rad = interp1(sc.UTCtime.data, sc.Q_ECI.data, d.s.TIMESTAMP(ind), 'nearest'); 
    
    bsight = [0 0 1]'; % boresight vector
    
    Rscan = getR_v2(rad.scanang.data(ind), 'x'); % rotation matrix for scan angle
    
    % Rotate boresight vector based on scan angle
    bvec_scan = nan(3,size(ECI_rad,1));
    for k = 1:3
        bvec_scan(k,:)= Rscan(:,k,1).*bsight(1)+Rscan(:,k,2).*bsight(2)+Rscan(:,k,3).*bsight(3);
    end
    norm_vec = ones(3,1)*sqrt(sum(bvec_scan.^2,1));
    bvec_scan=bvec_scan./norm_vec;
    
    [rad.SClat.data(ind), rad.SClon.data(ind), rad.SCalt.data(ind),rad.SCinc.data(ind), rad.blat.data(ind), rad.blon.data(ind), rad.binc.data(ind), rad.belev.data(ind), rad.bhorz.data(ind)] = CubeOlocate(ECI_rad,Q_ECI_rad,d.s.TIMESTAMP(ind),bvec_scan);
   
else
    dout = [{'No overlapping spacecraft position data found in: '};{sc.filename.data};{'!! skipping payload geolocation  !!'}];
    disp(' ')
    disp(char(dout))
    disp(' ')
end
