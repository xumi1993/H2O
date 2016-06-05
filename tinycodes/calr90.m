function r90 = calr90(phi1,phi2,phi3)
[x1,y1,z1,~] = calr0(phi1,phi2,phi3);
x2 = sind(phi3)*sind(phi2);
y2 = cosd(phi3)*sind(phi2);
z2 = cos(phi2);
r90 = abs(cross([x1,y1,z1],[x2,y2,z2]));
return