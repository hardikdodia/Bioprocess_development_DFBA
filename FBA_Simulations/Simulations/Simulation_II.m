%% Loading FVA and DFBA results
load('sim_variables.mat')
load('Process 4\model_results_param_modified_c_final.mat')
additions;

%% initialize parameters and user input (time) 

C_Oxy = (13.14e-3/32)*1000; %mM
DO = 173.28;
kla = 133; %h-1
ODCF = 0.37; % OD to gDCW/L Conversion Factor - 'ODCF' 
ind_amino = [10;12;14;18];
ind_amino = ind_flux(ind_amino);
factor = 5;


modelpFBA.lb(find(exchrxn)) = -1000;
modelpFBA.ub(find(exchrxn)) = 1000;
model = modelpFBA;

time = input("Please enter a time point:");
[time ,index] = min(abs(time-timesFBA));

%% Exchange reaction bounds

ind = findExcRxns(model);
model.lb(ind) = -factor*max(abs(solutionsWT.FVA_min(ind,index)),abs(solutionsWT.FVA_max(ind,index)));
model.ub(ind) = factor*max(abs(solutionsWT.FVA_min(ind,index)),abs(solutionsWT.FVA_max(ind,index)));
model.ub(ind_amino) =  max(solutionsWT.FVA_min(ind_amino,index),solutionsWT.FVA_max(ind_amino,index));%  4 amino acids

%% Growth bounds
model.lb(22) = solutionsWT.minabs(22,index); % solutionsWT.minabs is the DFBA solution
% model.ub(22) = factor*solutionsWT.minabs(22,index); % solutionsWT.minabs is the DFBA solution


%% Oxygen bounds
model = changeRxnBounds(model,'EX_o2_e',-(kla*(100))/((100/C_Oxy)*(ODCF*ODist(index))),'l'); 
model = changeRxnBounds(model,'EX_o2_e',1000,'u');
% model = changeRxnBounds(model,'EX_o2_e',solutionsWT.minabs(191,index));

%% Protein secretion bounds
model = changeRxnBounds(model,'EX_eyFP_c',solutionsWT.minabs(2769,index),'l'); 
model = changeRxnBounds(model,'EX_eyFP_c',factor*solutionsWT.minabs(2769,index),'u');


%% FBA Simulation
model.rev = double(model.lb<0 & model.ub>0);
model = changeObjective(model,'EX_eyFP_c');
results = solveLP(model,1);
% results = optimizeCbModel(model,'max','one');


%% %% Analysis

abs = results.x(ind_flux); % flux results of all absolute metabolites 
lb_abs= model.lb(ind_flux);
ub_abs = model.ub(ind_flux);
