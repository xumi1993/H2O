% the program is for determination of hydroxyl by infrared absorption
% Clibration method: Bell et al (2003) for olivine,Bell et al. (1995) for opx and cpx

% Generate a data file for one sample
clear;clc;fclose all;close all;

OUT_path = 'K:\hydroxyl';
filename = input ('Give a file name for your sample:', 's')
objname = regexp(char(filename), '[.]', 'split');

   [fp, msg] = fopen (filename,'r');
if fp == -1
   	disp(msg)
   else
      [result_1, count] = fscanf(fp,'%f');
      for i = 1: (count/2)
         wave(i) = result_1(2*i-1);
         absorp(i) = result_1(2*i);
     end
end
fclose(fp);

sample_ID = input ('Give your sample number:','s')
clf;
fg2 = gcf;
plot(wave, absorp, 'r', 'linewidth',1.5);
xlabel('Wavenumber (cm^-^1)');
ylabel('Absorption coefficient (cm^-^1)');
title( 'Original FTIR data');
set(fg2,'NumberTitle','off');
set(fg2,'Name',sample_ID);
hold on;

wave_min = input ('Input the minumum wavenumber for calculation:')
wave_max = input ('Input the maxumum wavenumber for calculation:')
j =1;
for i = 1: (count/2-1)
    if wave(i)>= wave_min & wave(i)<wave_max
        if wave(i) ~=wave (i+1)
        wavenumber(j) = wave(i);
        absorption(j) = absorp(i);
        j=j+1;
        end
    end
end
       
fg1 = figure;
clf;
plot(wavenumber, absorption, 'g', 'linewidth',1.5);
xlabel('Wavenumber (cm^-^1)');
ylabel('Absorption coefficient (cm^-^1)');
title(sample_ID);
set(fg1,'NumberTitle','off');
set(fg1,'Name',sample_ID);
grid on;
hold on;

% Background correction of absorption spectra was carried out by a spline
% fit of the baseline defined by points outside the OH-strtching region

tol = min(abs(absorption))*0.005				% error tolerence = 0.5%
[lp,values] = spaps(wavenumber,absorption,tol);  % cubic smoothing 

% set the baseline
point_max = input ('How many points in your baseline(minium = 2):');
point_i=1;
pause
text(wavenumber(1),absorption(1), '+');
x(point_i,1)=wavenumber(1);
y(point_i,1)=absorption(1);
while point_i<=point_max
    [baseline_X,baseline_Y] = ginput(1);
    disp(baseline_X)
    text(baseline_X, baseline_Y,'+');
    x(point_i+1,1)=baseline_X;
    y(point_i+1,1)=baseline_Y;
    tol_baseline=min(abs(y))*0.005;
    [lp_baseline,values]=spaps(x,y,tol_baseline);
    fnplt(lp_baseline, 'k--');
    point_i=point_i+1
    pause
end
new_absorp = absorption - fnval(lp_baseline, wavenumber); % baseline correction
plot(wavenumber, new_absorp, 'r')

% remove the contribution of OH-independent peaks

correct = input ('Do you want to remove more peaks? (y/n)','s')
   
    [correct_X1,correct_Y1] = ginput(1);
    text(correct_X1, correct_Y1,'x');
    [correct_X2,correct_Y2] = ginput(1);
    text(correct_X2, correct_Y2,'x');
    
    for k =1:length(wavenumber)
        if wavenumber(k) < correct_X1 | wavenumber(k) > correct_X2
           new_absorp(k)=0.0;
        end
    end      



tol_final = min(abs(new_absorp))*0.005;
[lp_final,values] =spaps(wavenumber, new_absorp,tol_final);

% calculate integral area of the final spectrum
step = (wave_max - wave_min)/1000
wave_cal(1) = correct_X1;
absorp_cal(1) = fnval(lp_final, correct_X1);
area_cal(1) = 0.0;
delta = 0.0;
for i =2:1000
    wave_cal (i) = wave_cal(i-1)+step;
    absorp_cal (i) = fnval (lp_final, wave_cal(i));
    area_cal(i) = (absorp_cal (i-1)+absorp_cal (i))*step/2;
    delta = delta + area_cal (i);
end

% plot final results in a new figure
fg3 = figure;
clf;
plot(wavenumber, new_absorp, 'b', 'linewidth', 1.5);
xlabel('Wavenumber (cm^-^1)');
ylabel('Absorption coefficient (cm^-^1)');
title(sample_ID);
set(fg3,'NumberTitle','off');
set(fg3,'Name',sample_ID);
hold on;

thickness = input ('Please input the sample thickness of (cm^-1):')
mineral = input ('What mineral are you measuring? (oli/opx/cpx)','s')
if mineral == 'oli'
    water = delta*0.188/thickness*3; % Bell et al. (2003) calibration
end
if mineral == 'opx'
    water = delta/7.09/thickness*3;
end
if mineral == 'cpx'
    water = delta/14.84/thickness*3;
end

lx= wave_min+(wave_max-wave_min)/20;
ly1 = max(absorp_cal)-(max(absorp_cal)-min(absorp_cal))/6;
ly2 = max(absorp_cal)-(max(absorp_cal)-min(absorp_cal))/4;
ly3 = max(absorp_cal)-(max(absorp_cal)-min(absorp_cal))/3;
text(lx,ly1,['Mineral = ',mineral]);
text(lx,ly2,['Integral area = ',num2str(delta,'%6.3f')]);
text(lx,ly3,['Water content (ppm) = ',num2str(water,'%6.3f')]);

print(fg3, '-dpdf', fullfile(OUT_path, [objname(1) '.pdf']));
