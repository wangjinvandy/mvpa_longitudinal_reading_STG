# mvpa_longitudinal_reading_STGIFG
## Code used for papaer entitled "A sculpting effect of reading on later representational quality of phonology revealed by multi-voxel pattern analysis in young children" 

 **Preprocessing example code** 
  preproc_main_nosmooth.m. This code reads in the normalized data from my Longitudinal_Reading_vOT project (see a preprocessing code at https://github.com/wangjinvandy/Longitudinal_Reading_vOT) and only does artrepiar after normalization without smoothing the data. 
 **Firstlevel example code**
	firstlevel_generate_bids_ELP.m. This code models each time point data one at a time for the contrasts of allwords_vs_perc, onset_vs_perc_run1, onset_vs_perc_run2, rhyme_vs_perc_run1, rhyme_vs_perc_run2, unrelated_vs_perc_run1, unrelated_vs_perc_run2. 
*Both preprocessing and firstlevel codes rely on SPM12.*
 **MVPA codes**
	topvoxel.sh. The topvoxels.sh code calls for AFNI functions to make the top-500 voxels within the posterior left STG mask for the contrast of allwords_vs_perc contrast. 
	ExtracConvaluesfromindvROIs.sh. The extractConvaluesfromindvROIs.sh calls for AFNI functions to extract the beta-values from the con-maps generated from SPM12 for onset_vs_perc_run1, onset_vs_perc_run2, rhyme_vs_perc_run1, rhyme_vs_perc_run2, unrelated_vs_perc_run1, unrelated_vs_perc_run2 from the top-500 voxels. 
	correlational_mvpa_analysis.m. The correlational_mvpa_anlaysis.m is a homemade matlab code for calculating the correlations across runs for either small grain sizes (Onset vs. Unrelated) or large grain sizes (Rhyme vs. Unrelated) at each time point. 
 *All the codes shared here is only an example for ses-5 in the younger cohort (children ages from 5 to 7). But one can easily modify the code by changing the ses-# to do analyses for each time point and then conduct the regression analysis to examine the hypotheses of this study outside using R or SPSS.* 
