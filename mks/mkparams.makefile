# ######################
# mkparams.makefile
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ######################

# SeRPeNT profiler parameters for ENCODE datasets
serpent_p_f = 18
serpent_p_i = idr:0.01
serpent_p_t = 0.1:11:25
serpent_p_p = 50:200:39:50

# SeRPeNT profiler parameters for KNOCKDOWN dataset
serpent_p_f_kd = 18
serpent_p_i_kd = idr:0.01
serpent_p_r_kd = pool
serpent_p_t_kd = 0.1:5:20
serpent_p_p_kd = 30:200:39:20

# SeRPeNT profiler parameters for GSM796510 dataset
serpent_p_f_bnm = 18
serpent_p_i_bnm = common
serpent_p_r_bnm = mean
serpent_p_t_bnm = 0.1:11:25
serpent_p_p_bnm = 50:200:39:50

# SeRPeNT profiles parameters for DIFFPROC BENCHMARK dataset
serpent_p_f_dpb = 18
serpent_p_r_dpb = pool
serpent_p_i_dpb = common
serpent_p_t_dpb = 0.05:11:30
serpent_p_p_dpb = 35:200:39:30

# SeRPeNT annotator parameters for GSM796510 dataset
serpent_a_a_bnm = dat/gencodev19_annotation_filtered.bed
serpent_a_o_bnm = 0.01:0.01

# SeRPeNT annotator parameters for ENCODE cell lines dataset
serpent_a_a = dat/gencodev19_annotation_nonfiltered.bed
serpent_a_o = 0.01:0.01

# SeRPeNT annotator parameters for ENCODE compartments dataset
serpent_a_a_c = dat/serpent_annotation_extended.bed
serpent_a_o_c = 0:0

# SeRPeNT diffproc parameters
serpent_d_g = 0.01:2.5

# Entropy cutoff for profiles in extended annotation
extended_cutoff = 0.2

# Predicted profiles validation parameters
mkvalidation_extension = 10
mkvalidation_pval = 0.05

# Differential processing in compartments parameters
mkdiffproc_cutoff = 0.01

# Model building for clusters in compartments parameters
cvm_extension = 10
cvm_number_clusters = 3
cvm_sequence_similarity = 80

# Main figure 2 Makefile parameters
mainfig2_sample = nhek

# Main Figure 3 Makefile parameters
mainfig3_nprofiles = 5
mainfig3_foldchange = 2.5

# Supplementary data 1 parameters
suppdat1_pvalue = 0.01
