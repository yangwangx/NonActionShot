ProjRoot=[fileparts(mfilename('fullpath')),'/']; % project root
MatlabRoot=[ProjRoot,'dependences/Matlab/'];     % matlab dependence root 

run([MatlabRoot,'vlfeat-0.9.20/toolbox/vl_setup.m']);    % VL_FEAT
run([MatlabRoot,'MHLfuncs/ml_setup.m']);                 % MHLFuncs

addpath(genpath([MatlabRoot,'liblinear-1.96/matlab']));  % liblinear
addpath(genpath([ProjRoot,'utils/Matlab']));             % my own code
