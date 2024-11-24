function q = FindFluxDO(OD,ODCF,DO,dMdt_DO,Feed_Time_Index,kla,C_Oxy,Volume,F)
    q = zeros(size(DO));
    V = Volume;
    
    Batch = [1:Feed_Time_Index];
    FedBatch1 = [Feed_Time_Index+1:900];
    FedBatch2 = [901:1200];
    FedBatch3 = [1201:1500];
    FedBatch4 = [1501:size(DO,1)];

    air=[1 0.95 0.90 0.85 0.80];

    q(Batch) = (dMdt_DO(Batch) - (kla*((100*(1-0.79*air(1))/0.21) - DO(Batch))))./((100/C_Oxy)*(ODCF*OD(Batch)));
    q(FedBatch1) = (dMdt_DO(FedBatch1) - (kla*((100*(1-0.79*air(2))/0.21) - DO(FedBatch1))) + ((F*DO(FedBatch1))./V(FedBatch1)))./((100/C_Oxy)*(ODCF*OD(FedBatch1)));
    q(FedBatch2) = (dMdt_DO(FedBatch2) - (kla*((100*(1-0.79*air(3))/0.21) - DO(FedBatch2))) + ((F*DO(FedBatch2))./V(FedBatch2)))./((100/C_Oxy)*(ODCF*OD(FedBatch2)));
    q(FedBatch3) = (dMdt_DO(FedBatch3) - (kla*((100*(1-0.79*air(4))/0.21) - DO(FedBatch3))) + ((F*DO(FedBatch3))./V(FedBatch3)))./((100/C_Oxy)*(ODCF*OD(FedBatch3)));
    q(FedBatch4) = (dMdt_DO(FedBatch4) - (kla*((100*(1-0.79*air(5))/0.21) - DO(FedBatch4))) + ((F*DO(FedBatch4))./V(FedBatch4)))./((100/C_Oxy)*(ODCF*OD(FedBatch4)));

end




