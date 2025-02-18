% Please ensure there is an excel sheet named iECD additions in the same
% path ; also , ensure that the protein exchange is the last reaction added


%% Import data from excel sheet
new_mets = readtable('iECD_additions.xlsx',Sheet = 'New_metabolites');

new_rxns = readtable('iECD_additions.xlsx',Sheet = 'New_reactions',VariableNamingRule='preserve',Range='A2');

exchange = readtable('iECD_additions.xlsx',Sheet='Exchange_reactions');

%% Adding metabolites and reactions

modelpFBA = addMultipleMetabolites(modelpFBA,new_mets.mets,'metNames',new_mets.metNames);

modelpFBA = addMultipleReactions(modelpFBA,new_rxns.Properties.VariableNames(4:end),modelpFBA.mets(new_rxns.index),table2array(new_rxns(:,4:end)));

modelpFBA.lb(end-3) = 0; % temporary solution ; must be changed later on
modelpFBA.lb(end) = 0;

metnum = exchange.idx ;

mets = exchange.rxns;


%% Add Exchange rxns
% load mets.mat

for i = 1:size(mets,1)
    modelpFBA = addExchangeRxn(modelpFBA,modelpFBA.mets(metnum(i)),exchange.LB(i),exchange.UB(i));
    modelpFBA.rxnNames(2746+i) = mets(i)  ;
end

%% Add Target Protein formation and exchange rxns to the GEM 
% stoic = [1,-9,-6,-13,-18,-2,-7,-16,-23,-9,-12,-22,-20,-5,-1,-13,-10,-9,-14,-1,-12,-17,-478,9,6,13,18,2,7,16,23,9,12,22,20,6,13,10,9,14,1,12,17,478,478];
% modelpFBA = addMetabolite(modelpFBA,'eYFP');
% modelpFBA = addReaction(modelpFBA,'eYFP_Prod','metaboliteList',{'eYFP','alatrna_c','argtrna_c','asntrna_c','asptrna_c','cystrna_c','glntrna_c','glutrna_c','glytrna_c','histrna_c','iletrna_c','leutrna_c','lystrna_c','mettrna_c','fmettrna_c','phetrna_c','protrna_c','sertrna_c','thrtrna_c','trptrna_c','tyrtrna_c','valtrna_c','gtp_c','trnaala_c','trnaarg_c','trnaasn_c','trnaasp_c','trnacys_c','trnagln_c','trnaglu_c','trnagly_c','trnahis_c','trnaile_c','trnaleu_c','trnalys_c','trnamet_c','trnaphe_c','trnapro_c','trnaser_c','trnathr_c','trnatrp_c','trnatyr_c','trnaval_c','gdp_c','pi_c'},'stoichCoeffList',stoic,'reversible',false);
% modelpFBA = addExchangeRxn(modelpFBA,'eYFP',0,1000);