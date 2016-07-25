run ../../setup.m

%% extract frames
! mkdir -p ./frames
clip.file = sprintf('%s/video/BigBangTheory_01x01.mp4',pwd);
outFrmDir = sprintf('%s/frames/',pwd);
opts=[]; opts.newH=360; opts.fps=25;
ML_VidClip.extFrms(clip, outFrmDir, opts);
imFiles = ml_getFilesInDir(outFrmDir, 'png');
nFrm=length(imFiles); %32989

%% get shots & threads
! mkdir -p ./shots
[shotBnds, threads] = ML_VidThread.getThreads(imFiles);
shots=[1,shotBnds;shotBnds-1,nFrm];
save('shots/shots.mat','nFrm','shotBnds','threads','shots');

%% create gifs
! mkdir -p ./shots/gifs
ML_VidThread.createHtmls(imFiles, shotBnds, threads, './shots/gifs/');

