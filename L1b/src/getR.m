function R = getR(theta, Daxis)
    
if nargin==2 
    theta = deg2rad(theta);
    if (Daxis == 'x')
        R = [1 0 0;0 cos(theta) -sin(theta);0 sin(theta) cos(theta)];
    elseif (Daxis == 'y')
        R = [cos(theta) 0 sin(theta);0 1 0; -sin(theta) 0 cos(theta)];
    elseif (Daxis == 'z')
        R = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];
    else
        warning('Function Use getR(theta[degrees], x or y or z');
    end
else
    warning('Function Use getR(theta[degrees], x or y or z)');
end