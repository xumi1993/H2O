
% the program is for determination of hydroxyl by infrared absorption
% Clibration method: Bell et al (2003) for olivine,Bell et al. (1995) for opx and cpx

load icon.mat ;
clf
global cfg


[p,f] = fileparts(mfilename('fullpath')); 
set(0,'DefaultFigurecolor', [224   223   227]/255 ,...
      'DefaultFigureWindowStyle','normal',...
      'DefaultUIControlBackgroundColor', [224   223   227]/255) 

defaultconfig;
p = get(0,'DefaultFigurePosition');
p(3:4)=[500 400];
figure(1);
set(gcf,'Position',p,'Resize','off',...
        'ToolBar','none',...
        'Menubar','none',...
        'name',cfg.version,...
        'NumberTitle','off');

GENERAL;
PARAMETER;

%% menu
m1 = uimenu(gcf,'Label',   'Files');
uimenu(m1,'Label',  'Save As',   'Callback','savepjt');
uimenu(m1,'Label',  'Load',   'Callback','loadpjt');


%% button
uicontrol('Units','pixel',...
          'Style','Pushbutton',...
          'Position',[10 25 100 35],...
          'String', 'Do determination',...
          'Callback','doH2O');
     
uicontrol('Units','pixel',...
          'Style','text',...
          'Position',[p(4)-60 5 140 35],...
          'String', 'Copyleft (C) 2015 Mijian Xu');

clear pos p f m1 h