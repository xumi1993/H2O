function savepjt(src,e)
global cfg
str ={'*.mat', '*.mat - MatLab files';
    '*.*',     '* - All files'};
[tmp1,tmp2]=uiputfile( str ,'Project file');
try
path = fullfile(tmp2,tmp1);
save(path,'cfg');
catch
    return
end
end
