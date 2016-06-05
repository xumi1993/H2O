function [x,y,z,r0] = calr0(phi1, phi2, phi3)
x = cosd(phi1)*cosd(phi3) - sind(phi1)*sind(phi3)*cosd(phi2);
y = -cosd(phi1)*sind(phi3) - sind(phi1)*cosd(phi3)*cosd(phi2);
z = sind(phi1)*sin(phi2);
r0 = sqrt(1/((x/3.4)^2+(y/0.7)^2+(z/1.17)^2));

return