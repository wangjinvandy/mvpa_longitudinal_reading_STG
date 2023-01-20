function correlational_analysis
%%The within and across task correlation code
subjects=[];
data_info='/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/jinwang/mvpa_PhonReading_5_7/scripts/participants.xlsx';
if isempty(subjects)
    M=readtable(data_info);
    subjects=M.participant_id;
end
root='/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/jinwang/mvpa_PhonReading_5_7/';

Tvaluefolder='extractedT_ses-5_postSTG_topvoxels_ROIs';
ROI='postSTG_allwords_vs_perc_p1_k500_adjust_mask';

writefile=[root '/' Tvaluefolder '_correlation_onset_vs_unrel_ses5.txt'];
cd(root);
if exist(writefile)
   delete(writefile);
end
fid_w=fopen(writefile,'w');
fprintf(fid_w, '%s %s %s %s %s %s\n', 'participant_id', 'withinOnset', 'withinUnrel', 'acrossOU', 'acrossUO', 'decoding_coef');

for i=1:length(subjects)
    
    txt_run1Cond1=[root '/' Tvaluefolder '/onset_vs_perc_run1/' subjects{i} '/' ROI '_onset_vs_perc_run1_output.txt'];
    fid=fopen(txt_run1Cond1);
    data1=textscan(fid,'%d %d %d %f');
    Cond1run1=data1{4};
    txt_run2Cond1=[root '/' Tvaluefolder '/onset_vs_perc_run2/' subjects{i} '/' ROI '_onset_vs_perc_run2_output.txt'];
    fid2=fopen(txt_run2Cond1);
    data2=textscan(fid2,'%d %d %d %f');
    Cond1run2=data2{4};
    withinCond1=corrcoef(Cond1run1, Cond1run2);
    r_withinCond1=withinCond1(1,2);
    %Fisher-z transformation
    rz_withinCond1=0.5*log((1+r_withinCond1)/(1-r_withinCond1));
    
    txt_run1Cond2=[root '/' Tvaluefolder '/unrelated_vs_perc_run1/' subjects{i} '/' ROI '_unrelated_vs_perc_run1_output.txt'];
    fid3=fopen(txt_run1Cond2);
    data3=textscan(fid3,'%d %d %d %f');
    Cond2run1=data3{4};
    txt_run2Cond2=[root '/' Tvaluefolder '/unrelated_vs_perc_run2/' subjects{i} '/' ROI '_unrelated_vs_perc_run2_output.txt'];
    fid4=fopen(txt_run2Cond2);
    data4=textscan(fid4,'%d %d %d %f');
    Cond2run2=data4{4};
    withinCond2=corrcoef(Cond2run1, Cond2run2);
    r_withinCond2=withinCond2(1,2);
    rz_withinCond2=0.5*log((1+r_withinCond2)/(1-r_withinCond2));
    
    acrossCond12=corrcoef(Cond1run1, Cond2run2); r_acrosstask1=acrossCond12(1,2);rz_acrosstask1=0.5*log((1+r_acrosstask1)/(1-r_acrosstask1));
    acrossCond21=corrcoef(Cond1run2, Cond2run1); r_acrosstask2=acrossCond21(1,2);rz_acrosstask2=0.5*log((1+r_acrosstask2)/(1-r_acrosstask2));
    decoding_coef=mean([rz_withinCond1-rz_acrosstask1,rz_withinCond2-rz_acrosstask2]);
    
    fprintf(fid_w, '%8s %4f %4f %4f %4f %4f %4f', subjects{i}, rz_withinCond1, rz_withinCond2, rz_acrosstask1, rz_acrosstask2, decoding_coef); 
    fprintf(fid_w,'\n');

end 

fclose(fid_w);