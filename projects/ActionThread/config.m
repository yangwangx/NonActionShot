%% Config
run '../../setup.m';
ATRoot=[ProjRoot,'data/ActionThread/'];
clipRoot=[ATRoot,'videos/'];

load([ATRoot,'NonAction.mat']);
All_videos=[NonAction.train.video;NonAction.test.video];
All_labels=[NonAction.train.label;NonAction.test.label];
All_shots=[NonAction.train.shots;NonAction.test.shots];
All_annos=[NonAction.train.shotsAnno;NonAction.test.shotsAnno];
nTrain=numel(NonAction.train.video);
nTest=numel(NonAction.test.video);

