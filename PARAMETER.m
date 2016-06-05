pos = [10 5 480 380];
h.panel(2) = uipanel('Units','pixel','Title','Set Parameters','FontSize',10,...
    'Position',pos + [0 60 0 -210], 'BackgroundColor', [224   223   227]/255 );
global cfg

%% wavenumber
uicontrol('Parent',h.panel(2),'Units','pixel',...
    'Style','text',...
    'Position',[10 120 150 20],...
    'String', 'The minumum wavenumber:',...
    'HorizontalAlignment','Left');

h.edit(4)=uicontrol('Parent',h.panel(2),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[170 125 60 20],...
    'ToolTipString','The minumum wavenumber',...
    'String', cfg.wave_min,...
    'Callback', 'cfg.wave_min=str2num(get(gcbo,''String''));');

uicontrol('Parent',h.panel(2),'Units','pixel',...
    'Style','text',...
    'Position',[10 90 150 20],...
    'String', 'The maxumum wavenumber:',...
    'HorizontalAlignment','Left');

h.edit(5)=uicontrol('Parent',h.panel(2),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[170 95 60 20],...
    'ToolTipString','The maxumum wavenumber',...
    'String', cfg.wave_max,...
    'Callback', 'cfg.wave_max=str2num(get(gcbo,''String''));');

uicontrol('Parent',h.panel(2),'Units','pixel',...
    'Style','text',...
    'Position',[10 60 190 20],...
    'String', 'Points in your baseline(minium = 2):',...
    'HorizontalAlignment','Left');

h.edit(6)=uicontrol('Parent',h.panel(2),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[200 65 60 20],...
    'ToolTipString','Points in your baseline(minium = 2)',...
    'String', cfg.point_max,...
    'Callback', 'cfg.point_max=str2num(get(gcbo,''String''));');

uicontrol('Parent',h.panel(2),'Units','pixel',...
    'Style','text',...
    'Position',[10 30 190 20],...
    'String', 'Sample thickness of (cm^-1):',...
    'HorizontalAlignment','Left');

h.edit(7)=uicontrol('Parent',h.panel(2),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[170 35 60 20],...
    'ToolTipString','Sample thickness of (cm^-1)',...
    'String', cfg.thickness,...
    'Callback', 'cfg.thickness=str2num(get(gcbo,''String''));');

uicontrol('Parent',h.panel(2),'Units','pixel',...
    'Style','text',...
    'Position',[300 130 170 20],...
    'String', 'What mineral are you measuring?',...
    'HorizontalAlignment','Left');


uicontrol('Parent',h.panel(2),'Units','pixel',...
          'Style','List','Min',1,'Max',3,...
          'BackgroundColor','w',...
          'Position',[330 80 100 50],...
          'Value',cfg.mineralnum,...
          'String', {'oli','opx','cpx'},...
          'Callback', 'cfg.mineralnum=get(gcbo,''Value''); str=get(gcbo,''String''); cfg.mineral=char(str(cfg.mineralnum));clear str ');

uicontrol('Parent',h.panel(2),'Units','pixel',...
    'Style','text',...
    'Position',[300 50 50 20],...
    'String', 'Phi1',...
    'HorizontalAlignment','Left');

h.edit(8)=uicontrol('Parent',h.panel(2),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[340 55 40 20],...
    'ToolTipString','Phi1',...
    'String', cfg.phi1,...
    'Callback', 'cfg.phi1=str2num(get(gcbo,''String''));');

uicontrol('Parent',h.panel(2),'Units','pixel',...
    'Style','text',...
    'Position',[300 27.5 50 20],...
    'String', 'Phi2',...
    'HorizontalAlignment','Left');

h.edit(9)=uicontrol('Parent',h.panel(2),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[340 32.5 40 20],...
    'ToolTipString','Phi2',...
    'String', cfg.phi2,...
    'Callback', 'cfg.phi1=str2num(get(gcbo,''String''));');

uicontrol('Parent',h.panel(2),'Units','pixel',...
    'Style','text',...
    'Position',[300 5 50 20],...
    'String', 'Phi3',...
    'HorizontalAlignment','Left');

h.edit(10)=uicontrol('Parent',h.panel(2),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[340 10 40 20],...
    'ToolTipString','Phi3',...
    'String', cfg.phi3,...
    'Callback', 'cfg.phi3=str2num(get(gcbo,''String''));');

% Radio Button
uicontrol('Parent',h.panel(2),'Units'  ,'pixel',...
    'Style'    ,'radiobutton',...
    'Value'    ,cfg.calx,...
    'Position' ,[400 40 70 20],...
    'String'   ,'deg 0',...
    'Tag','Use0',...
    'Callback' ,'cfg.calx=get(gcbo,''Value''); set(findobj(''Tag'',''Use90'') ,''Value'',0)');

uicontrol('Parent',h.panel(2),'Units'  ,'pixel',...
    'Style'    ,'radiobutton',...
    'Value'    ,~cfg.calx,...
    'Position' ,[400 15 70 20],...
    'String'   ,'deg 90',...
    'Tag','Use90',...
    'Callback' ,'cfg.calx=~get(gcbo,''Value''); set(findobj(''Tag'',''Use0'') ,''Value'',0)');