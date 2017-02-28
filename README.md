# NonActionShot

This repository contains:

- code for the CVPR 2016 paper  
  - Yang Wang, Minh Hoai. "Improving Human Action Recognition by Non-action Classification".    
  - [PDF] (http://www3.cs.stonybrook.edu/~cvl/content/papers/2016/nonaction_cvpr16.pdf)  
  - [Project Page](http://vision.cs.stonybrook.edu/~yangwang/home/doc/projects/NonAction/)  

- non-action shot classifier   
  -  [shotCLF.mat](https://github.com/yangwangx/NonActionShot/blob/master/projects/ActionThread/2.ClassifyNonAction/shotCLF.mat)
  -  learned from ActionThread  
  -  only based on iDTD + FV, without using CNN features  
  -  only used [inShot, outShot, <del>allVideo</del>] to represent a shot, which doesn't affect the performance.

- code for applying non-action shot classifier onto an entire episode


Usage (in Mac/Linux environment):  
1. Download this repository  
2. Download ActionThread using [script](https://github.com/yangwangx/NonActionShot/blob/master/data/get_data.sh)  
3. Install Matlab dependences listed [here](https://github.com/yangwangx/NonActionShot/blob/master/dependences/Matlab/get_code.txt)  
4. Get C dependences using [script](https://github.com/yangwangx/NonActionShot/blob/master/dependences/C/get_code.sh), and compile them correctly. Also, Modify `denseTrackBin` in [./utils/Matlab/YW_IDTD.m](https://github.com/yangwangx/NonActionShot/blob/master/utils/Matlab/YW_IDTD.m) to your own compiled binary.  
5. Follow the order [here](https://github.com/yangwangx/NonActionShot/tree/master/projects/ActionThread) to repeat experiments   
