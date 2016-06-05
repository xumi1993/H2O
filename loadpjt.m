function loadpjt(src,e)
global cfg
% str ={'*.mat', '*.mat - MatLab files';
%     '*.*',     '* - All files'};
[tmp1,tmp2]=uigetfile( '*.mat', '*.mat - MatLab files' ,'Open Project file');
load(fullfile(tmp2,tmp1));
GENERAL;
PARAMETER;
end
      