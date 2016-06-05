function doH2O

global cfg
%% read
% [fp, msg] = fopen (cfg.sampledir,'r');
% if fp == -1
%    	disp(msg)
%    else
%       [result_1, count] = fscanf(fp,'%f');
%       for i = 1: (count/2)
%          wave(i) = result_1(2*i-1);
%          absorp(i) = result_1(2*i);
%      end
% end
% fclose(fp);
[wave, absorp] =  textread(cfg.sampledir,'%f,%f',-1);
count = length(wave);
%% plot 1
fg2 = figure(2);
plot(wave, absorp, 'r', 'linewidth',1.5);
xlabel('Wavenumber (cm^-^1)');
ylabel('Absorption coefficient (cm^-^1)');
title( 'Original FTIR data');
set(fg2,'NumberTitle','off');
set(fg2,'Name',cfg.sampleID);
pos = get(fg2,'Position');
set(fg2,'Position',[35 400 pos(3) pos(4)]);
hold on;

j =1;
for i = 1: (count/2-1)
    if wave(i) >= cfg.wave_min & wave(i) < cfg.wave_max
        if wave(i) ~=wave (i+1)
        wavenumber(j) = wave(i);
        absorption(j) = absorp(i);
        j=j+1;
        end
    end
end

%% plot 2
fg1 = figure(3);
plot(wavenumber, absorption, 'g', 'linewidth',1.5);
xlabel('Wavenumber (cm^-^1)');
ylabel('Absorption coefficient (cm^-^1)');
title(cfg.sampleID);
set(fg1,'NumberTitle','off');
set(fg1,'Name',cfg.sampleID);
pos = get(fg1,'Position');
set(fg1,'Position',[pos(1)+250 400 pos(3) pos(4)]);
grid on;
hold on;


tol = min(abs(absorption))*0.005;				% error tolerence = 0.5%
[lp,values] = spaps(wavenumber,absorption,tol);  % cubic smoothing 


point_i=1;
pause
text(wavenumber(1),absorption(1), '+');
x(point_i,1)=wavenumber(1);
y(point_i,1)=absorption(1);
while point_i<=cfg.point_max
    [baseline_X,baseline_Y] = ginput(1);
    disp(baseline_X)
    text(baseline_X, baseline_Y,'+');
    x(point_i+1,1)=baseline_X;
    y(point_i+1,1)=baseline_Y;
    tol_baseline=min(abs(y))*0.005;
    [lp_baseline,values]=spaps(x,y,tol_baseline);
    fnplt(lp_baseline, 'k--');
    point_i=point_i+1;
    disp(['This is point' num2str(point_i)])
    pause
end

new_absorp = absorption - fnval(lp_baseline, wavenumber); % baseline correction
plot(wavenumber, new_absorp, 'r')

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

step = (cfg.wave_max - cfg.wave_min)/1000
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


%% plot 3
fg3 = figure(4);
clf;
plot(wavenumber, new_absorp, 'b', 'linewidth', 1.5);
xlabel('Wavenumber (cm^-^1)');
ylabel('Absorption coefficient (cm^-^1)');
title(cfg.sampleID);
set(fg3,'NumberTitle','off');
set(fg3,'Name',cfg.sampleID);
hold on;


if cfg.mineral == 'oli'
    if cfg.calx
        [~,~,~,r0] = calr0(cfg.phi1,cfg.phi2,cfg.phi3);
        water = delta*r0/cfg.thickness*3; % Bell et al. (2003) calibration
    else
        r90 = calr90(cfg.phi1,cfg.phi2,cfg.phi3);
        water = delta*r90/cfg.thickness*3;
    end
end
if cfg.mineral == 'opx'
    water = delta/7.09/cfg.thickness*3;
end
if cfg.mineral == 'cpx'
    water = delta/14.84/cfg.thickness*3;
end

lx= cfg.wave_min+(cfg.wave_max-cfg.wave_min)/20;
ly1 = max(absorp_cal)-(max(absorp_cal)-min(absorp_cal))/6;
ly2 = max(absorp_cal)-(max(absorp_cal)-min(absorp_cal))/4;
ly3 = max(absorp_cal)-(max(absorp_cal)-min(absorp_cal))/3;
text(lx,ly1,['Mineral = ',cfg.mineral]);
text(lx,ly2,['Integral area = ',num2str(delta,'%6.3f')]);
text(lx,ly3,['Water content (ppm) = ',num2str(water,'%6.3f')]);

end