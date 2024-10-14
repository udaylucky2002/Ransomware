function final_result()

max_len=950;
[net_ff final_feature_IWO]=genetic_modify_moth_selection(max_len);
%[net_ff final_feature_IWO]=genetic_modify_selection(max_len);
test_datset_size = 1400;
[Precision_IWO Recall_IWO Fmeasure_IWO Accuracy_IWO]=moth_flame_optimization_test(final_feature_IWO,net_ff,test_datset_size);

[mdl final_feature]=genetic_wolf_selection(max_len);
[Precision Recall Fmeasure Accuracy]=base_paper_test(final_feature,mdl,test_datset_size);

disp('-----------Base Paper model----------');
Precision 
Recall 
Fmeasure 
Accuracy
disp('-----------Moth Flame Optimization model----------');
Precision_IWO 
Recall_IWO 
Fmeasure_IWO 
Accuracy_IWO

end