# #######################
# mkbenchmarking.makefile
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# #######################

include mks/mkdefs.makefile
include mks/mkparams.makefile

# Set of rules for accuracy benchmarking

lines : a549 gm12878 helas3 hepg2 imr90 k562 mcf7 nhek sknsh

compartments : chromatin cytosol nucleolus nucleoplasm

knockdown : wild dicer drosha

benchmarking : bnm

diffprocbnm: dfpbnm


a549:
	@mkdir -p dat
	@mkdir -p dat/a549
	@if [ -a dat/a549/accuracy.stats ]; then echo "[LOG]   Accuracy stats for A549 exist"; fi
	@if [ -a dat/a549/accuracy.stats ]; then :; else echo "[LOG]   Generating accuracy stats for A549"; fi
	@if [ -a dat/a549/accuracy.stats ]; then :; else $(perlbin) src/benchmark_annotation_accuracy.pl dat/a549/profiles.dat dat/a549/crosscor.dat dat/a549/annotation.bed $(serpent_a_o) 100 > dat/a549/accuracy.stats; fi

gm12878:
	@mkdir -p dat
	@mkdir -p dat/gm12878
	@if [ -a dat/gm12878/accuracy.stats ]; then echo "[LOG]   Accuracy stats for GM12878 exist"; fi
	@if [ -a dat/gm12878/accuracy.stats ]; then :; else echo "[LOG]   Generating accuracy stats for GM12878"; fi
	@if [ -a dat/gm12878/accuracy.stats ]; then :; else $(perlbin) src/benchmark_annotation_accuracy.pl dat/gm12878/profiles.dat dat/gm12878/crosscor.dat dat/gm12878/annotation.bed $(serpent_a_o) 100 > dat/gm12878/accuracy.stats; fi

helas3:
	@mkdir -p dat
	@mkdir -p dat/helas3
	@if [ -a dat/helas3/accuracy.stats ]; then echo "[LOG]   Accuracy stats for HeLa-S3 exist"; fi
	@if [ -a dat/helas3/accuracy.stats ]; then :; else echo "[LOG]   Generating accuracy stats for HeLa-S3"; fi
	@if [ -a dat/helas3/accuracy.stats ]; then :; else $(perlbin) src/benchmark_annotation_accuracy.pl dat/helas3/profiles.dat dat/helas3/crosscor.dat dat/helas3/annotation.bed $(serpent_a_o) 100 > dat/helas3/accuracy.stats; fi

hepg2:
	@mkdir -p dat
	@mkdir -p dat/hepg2
	@if [ -a dat/hepg2/accuracy.stats ]; then echo "[LOG]   Accuracy stats for HepG2 exist"; fi
	@if [ -a dat/hepg2/accuracy.stats ]; then :; else echo "[LOG]   Generating accuracy stats for HepG2"; fi
	@if [ -a dat/hepg2/accuracy.stats ]; then :; else $(perlbin) src/benchmark_annotation_accuracy.pl dat/hepg2/profiles.dat dat/hepg2/crosscor.dat dat/hepg2/annotation.bed $(serpent_a_o) 100 > dat/hepg2/accuracy.stats; fi

huvec:
	@mkdir -p dat
	@mkdir -p dat/huvec
	@if [ -a dat/huvec/accuracy.stats ]; then echo "[LOG]   Accuracy stats for HUVEC exist"; fi
	@if [ -a dat/huvec/accuracy.stats ]; then :; else echo "[LOG]   Generating accuracy stats for HUVEC"; fi
	@if [ -a dat/huvec/accuracy.stats ]; then :; else $(perlbin) src/benchmark_annotation_accuracy.pl dat/huvec/profiles.dat dat/huvec/crosscor.dat dat/huvec/annotation.bed $(serpent_a_o) 100 > dat/huvec/accuracy.stats; fi

imr90:
	@mkdir -p dat
	@mkdir -p dat/imr90
	@if [ -a dat/imr90/accuracy.stats ]; then echo "[LOG]   Accuracy stats for IMR90 exist"; fi
	@if [ -a dat/imr90/accuracy.stats ]; then :; else echo "[LOG]   Generating accuracy stats for IMR90"; fi
	@if [ -a dat/imr90/accuracy.stats ]; then :; else $(perlbin) src/benchmark_annotation_accuracy.pl dat/imr90/profiles.dat dat/imr90/crosscor.dat dat/imr90/annotation.bed $(serpent_a_o) 100 > dat/imr90/accuracy.stats; fi

k562:
	@mkdir -p dat
	@mkdir -p dat/k562
	@if [ -a dat/k562/accuracy.stats ]; then echo "[LOG]   Accuracy stats for K562 exist"; fi
	@if [ -a dat/k562/accuracy.stats ]; then :; else echo "[LOG]   Generating accuracy stats for K562"; fi
	@if [ -a dat/k562/accuracy.stats ]; then :; else $(perlbin) src/benchmark_annotation_accuracy.pl dat/k562/profiles.dat dat/k562/crosscor.dat dat/k562/annotation.bed $(serpent_a_o) 100 > dat/k562/accuracy.stats; fi

mcf7:
	@mkdir -p dat
	@mkdir -p dat/mcf7
	@if [ -a dat/mcf7/accuracy.stats ]; then echo "[LOG]   Accuracy stats for MCF-7 exist"; fi
	@if [ -a dat/mcf7/accuracy.stats ]; then :; else echo "[LOG]   Generating accuracy stats for MCF-7"; fi
	@if [ -a dat/mcf7/accuracy.stats ]; then :; else $(perlbin) src/benchmark_annotation_accuracy.pl dat/mcf7/profiles.dat dat/mcf7/crosscor.dat dat/mcf7/annotation.bed $(serpent_a_o) 100 > dat/mcf7/accuracy.stats; fi

nhek:
	@mkdir -p dat
	@mkdir -p dat/nhek
	@if [ -a dat/nhek/accuracy.stats ]; then echo "[LOG]   Accuracy stats for NHEK exist"; fi
	@if [ -a dat/nhek/accuracy.stats ]; then :; else echo "[LOG]   Generating accuracy stats for NHEK"; fi
	@if [ -a dat/nhek/accuracy.stats ]; then :; else $(perlbin) src/benchmark_annotation_accuracy.pl dat/nhek/profiles.dat dat/nhek/crosscor.dat dat/nhek/annotation.bed $(serpent_a_o) 100 > dat/nhek/accuracy.stats; fi

sknsh:
	@mkdir -p dat
	@mkdir -p dat/sknsh
	@if [ -a dat/sknsh/accuracy.stats ]; then echo "[LOG]   Accuracy stats for SK-N-SH exist"; fi
	@if [ -a dat/sknsh/accuracy.stats ]; then :; else echo "[LOG]   Generating accuracy stats for SK-N-SH"; fi
	@if [ -a dat/sknsh/accuracy.stats ]; then :; else $(perlbin) src/benchmark_annotation_accuracy.pl dat/sknsh/profiles.dat dat/sknsh/crosscor.dat dat/sknsh/annotation.bed $(serpent_a_o) 100 > dat/sknsh/accuracy.stats; fi

chromatin:
	@mkdir -p dat
	@mkdir -p dat/chromatin
	@if [ -a dat/chromatin/accuracy.stats ]; then echo "[LOG]   Accuracy stats for Chromatin exist"; fi
	@if [ -a dat/chromatin/accuracy.stats ]; then :; else echo "[LOG]   Generating accuracy stats for Chromatin"; fi
	@if [ -a dat/chromatin/accuracy.stats ]; then :; else $(perlbin) src/benchmark_annotation_accuracy.pl dat/chromatin/profiles.dat dat/chromatin/crosscor.dat dat/chromatin/annotation.bed $(serpent_a_o) 100 > dat/chromatin/accuracy.stats; fi

cytosol:
	@mkdir -p dat
	@mkdir -p dat/cytosol
	@if [ -a dat/cytosol/accuracy.stats ]; then echo "[LOG]   Accuracy stats for Cytosol exist"; fi
	@if [ -a dat/cytosol/accuracy.stats ]; then :; else echo "[LOG]   Generating accuracy stats for Cytosol"; fi
	@if [ -a dat/cytosol/accuracy.stats ]; then :; else $(perlbin) src/benchmark_annotation_accuracy.pl dat/cytosol/profiles.dat dat/cytosol/crosscor.dat dat/cytosol/annotation.bed $(serpent_a_o) 100 > dat/cytosol/accuracy.stats; fi

nucleolus:
	@mkdir -p dat
	@mkdir -p dat/nucleolus
	@if [ -a dat/nucleolus/accuracy.stats ]; then echo "[LOG]   Accuracy stats for Nucleolus exist"; fi
	@if [ -a dat/nucleolus/accuracy.stats ]; then :; else echo "[LOG]   Generating accuracy stats for Nucleolus"; fi
	@if [ -a dat/nucleolus/accuracy.stats ]; then :; else $(perlbin) src/benchmark_annotation_accuracy.pl dat/nucleolus/profiles.dat dat/nucleolus/crosscor.dat dat/nucleolus/annotation.bed $(serpent_a_o) 100 > dat/nucleolus/accuracy.stats; fi

nucleoplasm:
	@mkdir -p dat
	@mkdir -p dat/nucleoplasm
	@if [ -a dat/nucleoplasm/accuracy.stats ]; then echo "[LOG]   Accuracy stats for Nucleoplasm exist"; fi
	@if [ -a dat/nucleoplasm/accuracy.stats ]; then :; else echo "[LOG]   Generating accuracy stats for Nucleoplasm"; fi
	@if [ -a dat/nucleoplasm/accuracy.stats ]; then :; else $(perlbin) src/benchmark_annotation_accuracy.pl dat/nucleoplasm/profiles.dat dat/nucleoplasm/crosscor.dat dat/nucleoplasm/annotation.bed $(serpent_a_o) 100 > dat/nucleoplasm/accuracy.stats; fi

wild:
	@mkdir -p dat
	@mkdir -p dat/wild
	@if [ -a dat/wild/accuracy.stats ]; then echo "[LOG]   Accuracy stats for Wild-type exist"; fi
	@if [ -a dat/wild/accuracy.stats ]; then :; else echo "[LOG]   Generating accuracy stats for Wild-type"; fi
	@if [ -a dat/wild/accuracy.stats ]; then :; else $(perlbin) src/benchmark_annotation_accuracy.pl dat/wild/profiles.dat dat/wild/crosscor.dat dat/wild/annotation.bed $(serpent_a_o) 100 > dat/wild/accuracy.stats; fi

dicer:
	@mkdir -p dat
	@mkdir -p dat/dicer
	@if [ -a dat/dicer/accuracy.stats ]; then echo "[LOG]   Accuracy stats for Dicer-KD exist"; fi
	@if [ -a dat/dicer/accuracy.stats ]; then :; else echo "[LOG]   Generating accuracy stats for Dicer-KD"; fi
	@if [ -a dat/dicer/accuracy.stats ]; then :; else $(perlbin) src/benchmark_annotation_accuracy.pl dat/dicer/profiles.dat dat/dicer/crosscor.dat dat/dicer/annotation.bed $(serpent_a_o) 100 > dat/dicer/accuracy.stats; fi

drosha:
	@mkdir -p dat
	@mkdir -p dat/drosha
	@if [ -a dat/drosha/accuracy.stats ]; then echo "[LOG]   Accuracy stats for Drosha-KD exist"; fi
	@if [ -a dat/drosha/accuracy.stats ]; then :; else echo "[LOG]   Generating accuracy stats for Drosha-KD"; fi
	@if [ -a dat/drosha/accuracy.stats ]; then :; else $(perlbin) src/benchmark_annotation_accuracy.pl dat/drosha/profiles.dat dat/drosha/crosscor.dat dat/drosha/annotation.bed $(serpent_a_o) 100 > dat/drosha/accuracy.stats; fi

bnm:
	@mkdir -p dat
	@mkdir -p dat/bnm
	@if [ -a dat/bnm/accuracy.stats ]; then echo "[LOG]   Accuracy stats for GSM769510 exist"; fi
	@if [ -a dat/bnm/accuracy.stats ]; then :; else echo "[LOG]   Generating accuracy stats for GSM769510"; fi
	@if [ -a dat/bnm/accuracy.stats ]; then :; else $(perlbin) src/benchmark_annotation_accuracy.pl dat/bnm/profiles.dat dat/bnm/crosscor.dat dat/bnm/annotation.bed $(serpent_a_o) 100 > dat/bnm/accuracy.stats; fi

dfpbnm:
	@mkdir -p bnm
	@if [ -a bnm/accuracy.stats ]; then echo "[LOG]   Accuracy stats for diffproc exist"; fi
	@if [ -a bnm/accuracy.stats ]; then :; else echo "[LOG]   Generating accuracy stats for diffproc"; fi
	@if [ -a bnm/profiles.bed ]; then :; else $(perlbin) src/extract_common_profiles.pl > bnm/profiles.bed; fi
	@if [ -a bnm/accuracy.stats ]; then :; else $(perlbin) src/benchmark_diffproc_profiles.pl bnm/profiles.bed dat/pundhir_dpl_all.bed 2.5 > bnm/accuracy.stats; fi
