%% Loading FVA and DFBA results
load('sim_variables.mat')
load('Process 2\model_results_param_modified_c_final.mat')
additions;

%% initialize parameters and user input (time) 

modelpFBA.lb(find(exchrxn)) = -1000;
modelpFBA.ub(find(exchrxn)) = 1000;
model = modelpFBA;

time = input("Please enter a time point:");
[time ,index] = min(abs(time-timesFBA));

%% Exchange reaction bounds

ind = findExcRxns(model);
model.lb(ind) = min(solutionsWT.FVA_min(ind,index),solutionsWT.FVA_max(ind,index));
model.ub(ind) = max(solutionsWT.FVA_min(ind,index),solutionsWT.FVA_max(ind,index));

%% Growth bounds
model.lb(22) = solutionsWT.minabs(22,index); % solutionsWT.minabs is the DFBA solution


%% Oxygen bounds
model = changeRxnBounds(model,'EX_o2_e',-1000,'l'); 
model = changeRxnBounds(model,'EX_o2_e',1000,'u');

%% Protein secretion bounds
model = changeRxnBounds(model,'EX_eyFP_c',solutionsWT.minabs(2769,index),'l'); 
model = changeRxnBounds(model,'EX_eyFP_c',1000,'u');


%% FBA Simulation
model.rev = double(model.lb<0 & model.ub>0);
model = changeObjective(model,'EX_eyFP_c');
results = solveLP(model,1);
% results = optimizeCbModel(model,'max','one');


%% %% Analysis

abs = results.x(ind_flux); % flux results of all absolute metabolites 
lb_abs= model.lb(ind_flux);
ub_abs = model.ub(ind_flux);
