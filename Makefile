# ######################
# Makefile
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ######################

include mks/mkdefs.makefile
include mks/mkparams.makefile

# Fast and accurate discovery and characterization of processed small non-coding RNAs by SeRPeNT
# - Figure 1
# - Supplementary Figure 1
# - Supplementary Figure 2
# - Supplementary Figure 3
# - Supplementary Figure 4
# - Supplementary Table 1
benchmarking:
	@echo "[LOG] Downloading data"
	@make -B -w -s --no-print-directory -f mks/mkdownload.makefile annotation        # Download Gencode annotation
	@make -B -w -s --no-print-directory -f mks/mkdownload.makefile benchmarking      # Download Benchmarking data
	@make -B -w -s --no-print-directory -f mks/mkdownload.makefile diffprocbnm       # Download Diffproc Benchmarking data
	@echo "[LOG] Executing SeRPeNT"
	@make -B -w -s --no-print-directory -f mks/mkprofiles.makefile benchmarking      # Execute SeRPeNT profiler for Benchmarking data
	@make -B -w -s --no-print-directory -f mks/mkprofiles.makefile diffprocbnm       # Execute SeRPeNT profiler for Diffproc Benchmarking data
	@make -B -w -s --no-print-directory -f mks/mkannotation.makefile benchmarking    # Execute SeRPeNT annotator for Benchmarking data
	@make -B -w -s --no-print-directory -f mks/mkannotation.makefile diffprocbnm     # Execute SeRPeNT annotator for Diffproc Benchmarking data
	@make -B -w -s --no-print-directory -f mks/mkdiffproc.makefile diffprocbnm       # Execute SeRPeNT diffproc for Diffproc Benchmarking data
	@echo "[LOG] Generating accuracy stats"
	@make -B -w -s --no-print-directory -f mks/mkbenchmarking.makefile benchmarking  # Generate accuracy stats for Benchmarking data
	@make -B -w -s --no-print-directory -f mks/mkbenchmarking.makefile diffprocbnm   # Generate accuracy stats for Diffproc Benchmarking data
	@echo "[LOG] Generating figures, tables and data"
	@make -B -w -s --no-print-directory -f mks/mkmain.makefile fig1                  # Figure 1
	@make -B -w -s --no-print-directory -f mks/mksupplementary.makefile fig1         # Supplementary Figure 1
	@make -B -w -s --no-print-directory -f mks/mksupplementary.makefile fig2         # Supplementary Figure 2
	@make -B -w -s --no-print-directory -f mks/mksupplementary.makefile fig3         # Supplementary Figure 3
	@make -B -w -s --no-print-directory -f mks/mksupplementary.makefile fig4         # Supplementary Figure 4
	@make -B -w -s --no-print-directory -f mks/mksupplementary.makefile tab1         # Supplementary Table 1

# An extended annotation of processed small non-coding RNAs in human
# - Figure 2a
# - Figure 2b
# - Figure 2c
# - Figure 4a
# - Figure 4b
# - Figure 4c
# - Supplementary Figure 5
# - Supplementary Figure 7
# - Supplementary Figure 8
# - Supplementary Figure 9
# - Supplementary Table 2
# - Supplementary Table 3
# - Supplementary Table 4
# - Supplementary Table 6
# - Supplementary Data 1
annotation:
	@echo "[LOG] Downloading data"
	@make -B -w -s --no-print-directory -f mks/mkdownload.makefile annotation        # Download Gencode annotation
	@make -B -w -s --no-print-directory -f mks/mkdownload.makefile lines             # Download ENCODE cell lines data
	@make -B -w -s --no-print-directory -f mks/mkdownload.makefile genome            # Download human genome assembly
	@echo "[LOG] Executing SeRPeNT"
	@make -B -w -s --no-print-directory -f mks/mkprofiles.makefile lines             # Execute SeRPeNT profiler for ENCODE cell lines data
	@make -B -w -s --no-print-directory -f mks/mkannotation.makefile lines           # Execute SeRPeNT annotator for ENCODE cell lines data
	@echo "[LOG] Generating accuracy stats"
	@make -B -w -s --no-print-directory -f mks/mkbenchmarking.makefile lines         # Generate accuracy stats for ENCODE cell lines data
	@echo "[LOG] Generating extended annotation"
	@make -B -w -s --no-print-directory -f mks/mkannotation.makefile extended        # Calculates entropy of predictions across ENCODE cell lines data
	@make -B -w -s --no-print-directory -f mks/mkvalidation.makefile extended        # Validate prediction of novel predicted profiles with Rfam db, Friedlander and DASHR
	@make -B -w -s --no-print-directory -f mks/mkvalidation.makefile knockdown       # Calculate differential expression between AGO-loaded and DICER-knockdown
	@echo "[LOG] Generating figures, tables and data"
	@make -B -w -s --no-print-directory -f mks/mkmain.makefile fig2a                 # Figure 2a
	@make -B -w -s --no-print-directory -f mks/mkmain.makefile fig2b                 # Figure 2b
	@make -B -w -s --no-print-directory -f mks/mkmain.makefile fig2c                 # Figure 2c
	@make -B -w -s --no-print-directory -f mks/mkmain.makefile fig4a                 # Figure 4a
	@make -B -w -s --no-print-directory -f mks/mkmain.makefile fig4b                 # Figure 4b
	@make -B -w -s --no-print-directory -f mks/mkmain.makefile fig4c                 # Figure 4c
	@make -B -w -s --no-print-directory -f mks/mksupplementary.makefile fig5         # Supplementary Figure 5
	@make -B -w -s --no-print-directory -f mks/mksupplementary.makefile fig7         # Supplementary Figure 7
	@make -B -w -s --no-print-directory -f mks/mksupplementary.makefile fig8         # Supplementary Figure 8
	@make -B -w -s --no-print-directory -f mks/mksupplementary.makefile fig9         # Supplementary Figure 9
	@make -B -w -s --no-print-directory -f mks/mksupplementary.makefile tab2         # Supplementary Table 2
	@make -B -w -s --no-print-directory -f mks/mksupplementary.makefile tab3         # Supplementary Table 3
	@make -B -w -s --no-print-directory -f mks/mksupplementary.makefile tab4         # Supplementary Table 4
	@make -B -w -s --no-print-directory -f mks/mksupplementary.makefile tab6         # Supplementary Table 6
	@make -B -w -s --no-print-directory -f mks/mksupplementary.makefile dat1         # Supplementary Data 1
	@make -B -w -s --no-print-directory -f mks/mksupplementary.makefile dat2         # Supplementary Data 2

# Differential processing of sRNAs among ENCODE cell compartments 
# - Figure 3a
# - Figure 3b
# - Figure 3c
# - Supplmentary Figure 6
# - Supplementary Table 5
# - Supplementary Data 2
diffproc:
	@echo "[LOG] Downloading data"
	@make -w -s --no-print-directory -f mks/mkdownload.makefile annotation        # Download Gencode annotation
	@make -w -s --no-print-directory -f mks/mkdownload.makefile compartments      # Download ENCODE cell compartments data
	@echo "[LOG] Executing SeRPeNT"
	@make -w -s --no-print-directory -f mks/mkprofiles.makefile compartments      # Execute SeRPeNT profiler for ENCODE cell compartments data
	@make -w -s --no-print-directory -f mks/mkannotation.makefile compartments    # Execute SeRPeNT annotator for ENCODE cell compartments data
	@make -w -s --no-print-directory -f mks/mkdiffproc.makefile compartments      # Execute SeRPeNT diffproc for ENCODE cell compartments data
	@echo "[LOG] Generating figures, tables and data"
	@make -w -s --no-print-directory -f mks/mkmain.makefile fig3a                 # Figure 3a
	@make -w -s --no-print-directory -f mks/mkmain.makefile fig3b                 # Figure 3b
	@make -w -s --no-print-directory -f mks/mkmain.makefile fig3c                 # Figure 3c
	@make -w -s --no-print-directory -f mks/mksupplementary.makefile fig6         # Supplementary Figure 6
	@make -w -s --no-print-directory -f mks/mksupplementary.makefile tab5         # Supplementary Table 5
	@make -w -s --no-print-directory -f mks/mksupplementray.makefile dat3         # Supplementary Data 3

# Rule for cleaning benchmarking data
cleanb:
	@rm -rf bnm/a549
	@rm -rf bnm/ag04450
	@rm -rf bnm/bj
	@rm -rf bnm/gm12878
	@rm -rf bnm/h1hesc
	@rm -rf bnm/helas3
	@rm -rf bnm/hepg2
	@rm -rf bnm/mcf7
	@rm -rf bnm/sknsh
	@rm -rf bnm/normal/*.dat
	@rm -rf bnm/normal/*.bed
	@rm -rf bnm/tumour/*.dat
	@rm -rf bnm/tumour/*.bed
	@rm -rf bnm/profiles.bed
	@rm -rf dfp/a549vsmcf7
	@rm -rf dfp/ag04450vsbj
	@rm -rf dfp/ag04450vsh1hesc
	@rm -rf dfp/ag04450vshepg2
	@rm -rf dfp/bjvsh1hesc
	@rm -rf dfp/bjvshepg2
	@rm -rf dfp/gm12878vshelas3
	@rm -rf dfp/h1hescvshelas3
	@rm -rf dfp/helas3vshepg2
	@rm -rf dfp/normalvstumour
	@rm -rf dfp/a549vssknsh
	@rm -rf dfp/ag04450vsgm12878
	@rm -rf dfp/ag04450vshelas3
	@rm -rf dfp/bjvsgm12878
	@rm -rf dfp/bjvshelas3
	@rm -rf dfp/gm12878vsh1hesc
	@rm -rf dfp/gm12878vshepg2
	@rm -rf dfp/h1hescvshepg2
	@rm -rf dfp/mcf7vssknsh

# Rule for cleanning annotation data
cleana:
	@rm -rf dat/a549
	@rm -rf dat/gm12878
	@rm -rf dat/helas3
	@rm -rf dat/hepg2
	@rm -rf dat/imr90
	@rm -rf dat/k562
	@rm -rf dat/mcf7
	@rm -rf dat/nhek
	@rm -rf dat/sknsh
	@rm -rf dat/serpent_annotation_novel.fa
	@rm -rf dat/serpent_annotation_novel.hits
	@rm -rf fig/supp/supplementary_data_1.tab

# Rule for cleaning compartments
cleanc:
	@rm -rf dat/chromatin/*
	@rm -rf dat/cytosol/*
	@rm -rf dat/nucleolus/*
	@rm -rf dat/nucleoplasm/*

# Rule for cleaning knockdown data
cleank:
	@rm -f dat/wild/*.dat
	@rm -f dat/wild/*.bed
	@rm -f dat/wild/*.neWick
	@rm -f dat/dicer/*.dat
	@rm -f dat/dicer/*.bed
	@rm -f dat/dicer/*.neWick
	@rm -f dat/drosha/*.dat
	@rm -f dat/drosha/*.bed
	@rm -f dat/drosha/*.neWick
	@rm -f dfp/wtvsdcr/*
	@rm -f dfp/wtvsdrsh/*
