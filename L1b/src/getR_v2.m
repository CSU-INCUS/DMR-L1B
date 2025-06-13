function R = getR_v2(theta, Daxis)

%theta [Nx1]

if nargin==2 
    theta = deg2rad(theta);
    if (Daxis == 'x')
        
        Rxx = ones(length(theta),1);
        Rxy = zeros(length(theta),1);
        Rxz = zeros(length(theta),1);
        
        
        Ryx = zeros(length(theta),1);
        Ryy = cos(theta);
        Ryz = -sin(theta);
        
        
        Rzx = zeros(length(theta),1);
        Rzy = sin(theta);
        Rzz = cos(theta);
        
        
        
    elseif (Daxis == 'y')
        
        Rxx = cos(theta);
        Rxy = zeros(length(theta),1);
        Rxz = sin(theta);
        
        
        Ryx = zeros(length(theta),1);
        Ryy = ones(length(theta),1);
        Ryz = zeros(length(theta),1);
        
        
        Rzx = -sin(theta);
        Rzy = zeros(length(theta),1);
        Rzz = cos(theta);
        
    
    elseif (Daxis == 'z')
      
        Rxx = cos(theta);
        Rxy = -sin(theta);
        Rxz = zeros(length(theta),1);
        
        
        Ryx = sin(theta);
        Ryy = cos(theta);
        Ryz = zeros(length(theta),1);
        
        
        Rzx = zeros(length(theta),1);
        Rzy = zeros(length(theta),1);
        Rzz = ones(length(theta),1);
        
    else
        warning('Function Use getR(theta[degrees], x or y or z');
    end
else
    warning('Function Use getR(theta[degrees], x or y or z)');
end


R(:,1,1) = Rxx;
R(:,1,2) = Rxy;
R(:,1,3) = Rxz;

R(:,2,1) = Ryx;
R(:,2,2) = Ryy;
R(:,2,3) = Ryz;

R(:,3,1) = Rzx;
R(:,3,2) = Rzy;
R(:,3,3) = Rzz;
