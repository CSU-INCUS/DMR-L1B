function [ECEFintercept] = WGS84_intercept(ECEFpos, ECEFbsight)

a = 6378137;
b = 6356752.3142;

x = ECEFpos(1,:);
y = ECEFpos(2,:);
z = ECEFpos(3,:);

u = ECEFbsight(1,:);
v = ECEFbsight(2,:);
w = ECEFbsight(3,:);


t = -(1./(b.^2.*(u.^2 + v.^2) +  a.^2.*w.^2)).*(b^2.*(u.*x + v.*y) + a^2.*w.*z + 0.5.*sqrt(...
     4.*(b^2.*(u.*x + v.*y) + a^2.*w.*z).^2 -... 
     4.*(b^2.*(u.^2 + v.^2) + a^2.*w.^2).*(b^2.*(-a^2 + x.^2 + y.^2) + a^2.* z.^2)));

t(~isreal(t))=NaN;
t(abs(t)>2000000)=NaN;
t=real(t);
 
ECEFintercept(1,:) = x+t.*u;
ECEFintercept(2,:) = y+t.*v;
ECEFintercept(3,:) = z+t.*w;

 

 
 