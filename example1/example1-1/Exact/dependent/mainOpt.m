%% ========================================================================
%  main program (example1-1)
%  written by Dongjin Lee (dongjin-lee@uiowa.edu) 
% RDO for mathematical functions
% save history for every iterations 
% data name
% - Exact : resultE
% - Direct approach : resultD
% - Singular Step GPCE : resultS
% - Multipoint approximation : resultM
%% ========================================================================
clear all
clc 
global cntObj cntCon 
global cntY1 cntY2
global stat0 statf sopt

estExact = cell(5,1);
x0 = [5,5];

cntObj=0; cntCon=0; 

%% options: 'pre', 'run', 'post' 
% 'pre' : save the stat# at the initial design 
% 'run' : do optimization  
% 'post' : save the stat# at the optimum design 

% pre-estimation of stat# and constraint value at initial design 
sopt = 'pre';
[stat0] = estExactobjfun(x0);
[c0,~,~,~] =  exactConfun(x0);

FilNam = sprintf('resultExact.mat');
cntY1 = 0; cntY2 = 0;
% run optimization
sopt = 'run';
[historyExact, searchdirExact] = runfmincon(x0);
estExact{5,1} = [cntY1, cntY2]; % function call # for Y1 and Y2  
xf = historyExact.x(end,:);
% post-estimation of statf and constraint value at optimum design  
sopt = 'post';  

[statf] = estExactobjfun(xf); 
[cf,~,~,~] =  exactConfun(xf);

estExact{1,1}  = stat0; % mean and variance at initial design 
estExact{2,1} = statf; % mean and variance at optimum design 
estExact{3,1} = c0; % constraint value at initial design
estExact{4,1}  = cf; % constraint value at optimum design 
save(FilNam, 'historyExact','estExact');