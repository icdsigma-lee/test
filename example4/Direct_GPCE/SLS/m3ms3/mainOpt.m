%% ========================================================================
%  main program (example3)
%  written by Dongjin Lee (dongjin-lee@uiowa.edu) 
% RDO for mathematical functions
% save history for every iterations 
% data name 
% - Exact : resultE
% - Direct approach : resultD# (#th-order GPCE)
% - Singular Step GPCE : resultS# (#th-order GPCE)
% - Multipoint approximation : resultM# (#th-order GPCE)
%% ========================================================================
clear all
clc 

global cntObj cntCon  
global cntRspObj cntRspCon
global stat0 statf
global sopt 

est = cell(5,1);
x0 = ones(1,10)*30; %initial desgin 

%% create an monomial moment matrix for initial design
genGramMatrix % Save ID, QQ (whitenning tran. matrix)

%% estimate statistics and do feasible estimation  
% Obj. and const. func. saves the relevant info. at the first iter.  
cntObj=0; cntCon=0; cntRspObj=0; cntRspCon=0;

%% objective has options as 'pre', 'run', 'post' 
% 'pre' : save the stat. for the initial design 
% 'run' : do not save any stat. info. 
% 'post' : save the stat. for the optimum 

% pre-estimation of stat and constraint value for init. 
sopt = 'pre';
[~,~] = objfun(x0); 
[c0,~,~,~] =  confun(x0);

% init. count # 
FilNam = sprintf('resultD3.mat');
% run optimization
sopt = 'run';
[history, searchdir] = runfmincon(x0);
xf = history.x(end,:);
cntRspObj1 = cntRspObj;
cntRspCon1 = cntRspCon;
est{5,1} = [ cntRspObj1, cntRspCon1]'; % function call # for Y1 and Y2  
% post-estimation of stat and constraint value for optimum  
sopt = 'post';
[~,~] = objfun(xf); 
[cf,~,~,~] =  confun(xf);
est{1,1}  = stat0'; % mean and variance at initial design 
est{2,1} = statf'; % mean and variance at optimum design 
est{3,1} = c0; % constraint value at initial design
est{4,1}  = cf; % constraint value at optimum design 
save(FilNam, 'history','est');