function defaultconfig
%DEFAULTCONFIG Summary of this function goes here
%   Detailed explanation goes here

global cfg

cfg.version = 'H2O 1.0.0';

if ispc
    cfg.host= getenv('COMPUTERNAME');
    user = getenv('USERNAME');
    home =  getenv('USERPROFILE');
else
    cfg.host = getenv('HOSTNAME');
    user= getenv('USER');
    home= getenv('HOME');
end

cfg.sampledir = fullfile(home,'*.dat');
cfg.sampleID = 'default_ID';
cfg.outpath = home;

cfg.wave_min = 3000;
cfg.wave_max = 3800;
cfg.point_max = 10;
cfg.thickness = 0.1;
cfg.mineralnum = 1;
cfg.mineral = 'oli';
cfg.phi1 = 0;
cfg.phi2 = 0;
cfg.phi3 = 0;
cfg.calx = 1;

end

