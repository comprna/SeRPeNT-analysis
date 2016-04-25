# ######################
# mkmodels.makefile
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ######################

include mks/mkdefs.makefile
include mks/mkparams.makefile

# Set of rules for model building

lines: a549 gm12878 helas3 hepg2 imr90 k562 mcf7 nhek sknsh

compartments: chromatin cytosol nucleolus nucleoplasm

knockdown: wild dicer drosha

benchmarking: bnm

a549:
	@mkdir -p cvm
	@echo "[LOG]   Generating covariance models from clusters in A549"
	@$(perlbin) src/retrieve_cluster_sequences.pl a549 dat/a549/annotation.bed $(cvm_extension) $(cvm_number_clusters) $(cvm_sequence_similarity)
	@$(perlbin) src/align_cluster_sequences.pl a549
	@$(perlbin) src/search_cluster_hits.pl a549

gm12878:
	@mkdir -p cvm
	@echo "[LOG]   Generating covariance models from clusters in GM12878"
	@$(perlbin) src/retrieve_cluster_sequences.pl gm12878 dat/gm12878/annotation.bed $(cvm_extension) $(cvm_number_clusters) $(cvm_sequence_similarity)
	@$(perlbin) src/align_cluster_sequences.pl gm12878
	@$(perlbin) src/search_cluster_hits.pl gm12878

helas3:
	@mkdir -p cvm
	@echo "[LOG]   Generating covariance models from clusters in HeLa-S3"
	@$(perlbin) src/retrieve_cluster_sequences.pl helas3 dat/helas3/annotation.bed $(cvm_extension) $(cvm_number_clusters) $(cvm_sequence_similarity)
	@$(perlbin) src/align_cluster_sequences.pl helas3
	@$(perlbin) src/search_cluster_hits.pl helas3

hepg2:
	@mkdir -p cvm
	@echo "[LOG]   Generating covariance models from clusters in HepG2"
	@$(perlbin) src/retrieve_cluster_sequences.pl hepg2 dat/hepg2/annotation.bed $(cvm_extension) $(cvm_number_clusters) $(cvm_sequence_similarity)
	@$(perlbin) src/align_cluster_sequences.pl hepg2
	@$(perlbin) src/search_cluster_hits.pl hepg2

huvec:
	@mkdir -p cvm
	@echo "[LOG]   Generating covariance models from clusters in HUVEC"
	@$(perlbin) src/retrieve_cluster_sequences.pl huvec dat/huvec/annotation.bed $(cvm_extension) $(cvm_number_clusters) $(cvm_sequence_similarity)
	@$(perlbin) src/align_cluster_sequences.pl huvec
	@$(perlbin) src/search_cluster_hits.pl huvec

imr90:
	@mkdir -p cvm
	@echo "[LOG]   Generating covariance models from clusters in IMR90"
	@$(perlbin) src/retrieve_cluster_sequences.pl imr90 dat/imr90/annotation.bed $(cvm_extension) $(cvm_number_clusters) $(cvm_sequence_similarity)
	@$(perlbin) src/align_cluster_sequences.pl imr90
	@$(perlbin) src/search_cluster_hits.pl imr90

k562:
	@mkdir -p cvm
	@echo "[LOG]   Generating covariance models from clusters in K562"
	@$(perlbin) src/retrieve_cluster_sequences.pl k562 dat/k562/annotation.bed $(cvm_extension) $(cvm_number_clusters) $(cvm_sequence_similarity)
	@$(perlbin) src/align_cluster_sequences.pl k562
	@$(perlbin) src/search_cluster_hits.pl k562

mcf7:
	@mkdir -p cvm
	@echo "[LOG]   Generating covariance models from clusters in MCF-7"
	@$(perlbin) src/retrieve_cluster_sequences.pl mcf7 dat/mcf7/annotation.bed $(cvm_extension) $(cvm_number_clusters) $(cvm_sequence_similarity)
	@$(perlbin) src/align_cluster_sequences.pl mcf7
	@$(perlbin) src/search_cluster_hits.pl mcf7

nhek:
	@mkdir -p cvm
	@echo "[LOG]   Generating covariance models from clusters in NHEK"
	@$(perlbin) src/retrieve_cluster_sequences.pl nhek dat/nhek/annotation.bed $(cvm_extension) $(cvm_number_clusters) $(cvm_sequence_similarity)
	@$(perlbin) src/align_cluster_sequences.pl nhek
	@$(perlbin) src/search_cluster_hits.pl nhek

sknsh:
	@mkdir -p cvm
	@echo "[LOG]   Generating covariance models from clusters in SK-N-SH"
	@$(perlbin) src/retrieve_cluster_sequences.pl sknsh dat/sknsh/annotation.bed $(cvm_extension) $(cvm_number_clusters) $(cvm_sequence_similarity)
	@$(perlbin) src/align_cluster_sequences.pl sknsh
	@$(perlbin) src/search_cluster_hits.pl sknsh

chromatin:
	@mkdir -p cvm
	@echo "[LOG]   Generating covariance models from clusters in Chromatin"
	@$(perlbin) src/retrieve_cluster_sequences.pl chromatin dat/chromatin/annotation.bed $(cvm_extension) $(cvm_number_clusters) $(cvm_sequence_similarity)
	@$(perlbin) src/align_cluster_sequences.pl chromatin
	@$(perlbin) src/search_cluster_hits.pl chromatin

cytosol:
	@mkdir -p cvm
	@echo "[LOG]   Generating covariance models from clusters in Cytosol"
	@$(perlbin) src/retrieve_cluster_sequences.pl cytosol dat/cytosol/annotation.bed $(cvm_extension) $(cvm_number_clusters) $(cvm_sequence_similarity)
	@$(perlbin) src/align_cluster_sequences.pl cytosol
	@$(perlbin) src/search_cluster_hits.pl cytosol

nucleolus:
	@mkdir -p cvm
	@echo "[LOG]   Generating covariance models from clusters in Nucleolus"
	@$(perlbin) src/retrieve_cluster_sequences.pl nucleolus dat/nucleolus/annotation.bed $(cvm_extension) $(cvm_number_clusters) $(cvm_sequence_similarity)
	@$(perlbin) src/align_cluster_sequences.pl nucleolus
	@$(perlbin) src/search_cluster_hits.pl nucleolus

nucleoplasm:
	@mkdir -p cvm
	@echo "[LOG]   Generating covariance models from clusters in Nucleoplasm"
	@$(perlbin) src/retrieve_cluster_sequences.pl nucleoplasm dat/nucleoplasm/annotation.bed $(cvm_extension) $(cvm_number_clusters) $(cvm_sequence_similarity)
	@$(perlbin) src/align_cluster_sequences.pl nucleoplasm
	@$(perlbin) src/search_cluster_hits.pl nucleoplasm

wild:
	@mkdir -p cvm
	@echo "[LOG]   Generating covariance models from clusters in Wild-type"
	@$(perlbin) src/retrieve_cluster_sequences.pl wild dat/wild/annotation.bed $(cvm_extension) $(cvm_number_clusters) $(cvm_sequence_similarity)
	@$(perlbin) src/align_cluster_sequences.pl wild
	@$(perlbin) src/search_cluster_hits.pl wild

dicer:
	@mkdir -p cvm
	@echo "[LOG]   Generating covariance models from clusters in Dicer-KD"
	@$(perlbin) src/retrieve_cluster_sequences.pl dicer dat/dicer/annotation.bed $(cvm_extension) $(cvm_number_clusters) $(cvm_sequence_similarity)
	@$(perlbin) src/align_cluster_sequences.pl dicer
	@$(perlbin) src/search_cluster_hits.pl dicer

drosha:
	@mkdir -p cvm
	@echo "[LOG]   Generating covariance models from clusters in Drosha-KD"
	@$(perlbin) src/retrieve_cluster_sequences.pl drosha dat/drosha/annotation.bed $(cvm_extension) $(cvm_number_clusters) $(cvm_sequence_similarity)
	@$(perlbin) src/align_cluster_sequences.pl drosha
	@$(perlbin) src/search_cluster_hits.pl drosha

bnm:
	@mkdir -p cvm
	@echo "[LOG]   Generating covariance models from clusters in GSM769510"
	@$(perlbin) src/retrieve_cluster_sequences.pl bnm dat/bnm/annotation.bed $(cvm_extension) $(cvm_number_clusters) $(cvm_sequence_similarity)
	@$(perlbin) src/align_cluster_sequences.pl bnm
	@$(perlbin) src/search_cluster_hits.pl bnm
