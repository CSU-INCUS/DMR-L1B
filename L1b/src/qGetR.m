function R = qGetR(Qrotation)
% qGetR: get a 3x3 rotation matrix for a vector input of quaternions
% R = qGetR( Qrotation )
% IN: 
%     Qrotation - quaternion describing rotation  [Nx4]
% 
% OUT:
%     R - rotation matrix [Nx3x3]
%     
% VERSION: 03.03.2012

R = nan(size(Qrotation,1),3,3);

w = Qrotation(:,1);
x = Qrotation(:,2);
y = Qrotation(:,3);
z = Qrotation(:,4);

Rxx = 1 - 2.*(y.^2 + z.^2);
Rxy = 2.*(x.*y - z.*w);
Rxz = 2.*(x.*z + y.*w);

Ryx = 2.*(x.*y + z.*w);
Ryy = 1 - 2.*(x.^2 + z.^2);
Ryz = 2.*(y.*z - x.*w );

Rzx = 2.*(x.*z - y.*w );
Rzy = 2.*(y.*z + x.*w );
Rzz = 1 - 2.*(x.^2 + y.^2);

R(:,1,1) = Rxx;
R(:,1,2) = Rxy;
R(:,1,3) = Rxz;

R(:,2,1) = Ryx;
R(:,2,2) = Ryy;
R(:,2,3) = Ryz;

R(:,3,1) = Rzx;
R(:,3,2) = Rzy;
R(:,3,3) = Rzz;


% R = [ 
%     Rxx,    Rxy,    Rxz;
%     Ryx,    Ryy,    Ryz;
%     Rzx,    Rzy,    Rzz];