Prerequisite:  it is preferable to have the RAVEN and COBRA toolbox installed*. 
 
To access the simulations, follow these steps:

1) Navigate to FBA_Simulations -> Simulations
2) There are 4 MATLAB scripts available, each named Simulation_I and Simulation_II as mentioned in the manuscript.
3) Open any of the 2 scripts and execute the code to obtain the simulation results. When prompted, enter '17' or '22' to get the desired results discussed in the manuscript. This input is the time point at which FBA is run
4) To retrieve all the fluxes at that time point, type results.x in the command line.
5) To access only the fluxes of the exchange reactions of the absolute metabolites, check the variable 'abs'. 

*NOTE: If RAVEN is not available, go to the "FBA Simulation" Section in the code and uncomment lines 38 and 50 in Simulation_I and Simulation_II respectively. Also, comment out Lines 37 and 49 in Simulation_I and Simulation_II respectively.



To access the results, Navigate to FBA_Simulations -> Results
1) There is an Excel file named "Results" with two sheets "Simulation I" and "Simulation II"
2) In each sheet, the FBA results are summarized for all reactions at two time points :  17h and 22h
3) At both time points, fluxes are summarized along with their bounds during simulation (LB and UB stands for lower and upper bound)
4) Units of fluxes: mmol/(gDCW.h)


Description of the variables :

solutionsWT: A structure variable obtained from the DFBA simulations: saved under the variable name 'model_results_param_modified_c_final.mat' . its variables 'minabs' contain the DFBA simulation results of that particular process

modelpFBA: Genome-Scale Model iECD391

exchrxn: matrix indicating the exchange reactions in the model

indflux, indfluxr : indices of the absolute and relative exchange reactions respectively

ODist, timesFBA: OD and time points at which DFBA was run

