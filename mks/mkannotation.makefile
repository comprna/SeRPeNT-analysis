# ######################
# mkannotate.makefile
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ######################

include mks/mkdefs.makefile
include mks/mkparams.makefile

# Set of rules for profile clustering and annotation

lines: linesant a549 gm12878 helas3 hepg2 imr90 k562 mcf7 nhek sknsh

compartments: chromatin cytosol nucleolus nucleoplasm

knockdown: wild dicer drosha

benchmarking: bnmant bnm

diffprocbnm: dfpa549 dfpag04450 dfpbj dfph1hesc dfphelas3 dfphepg2 dfpgm12878 dfpmcf7 dfpsknsh dfpnormal dfptumour

extended:
	@mkdir -p dat
	@if [ -a dat/serpent_annotation_extended.bed ]; then echo "[LOG]   SeRPeNT extended annotation exist"; fi
	@if [ -a dat/serpent_annotation_extended.bed ]; then :; else echo "[LOG]   Generating SeRPeNT extended annotation"; fi
	@if [ -a dat/serpent_annotation_novel.bed ]; then :; else $(perlbin) src/benchmark_novel_profiles.pl $(extended_cutoff) dat/hg19_blacklist_mappability.bed > dat/serpent_annotation_novel.bed; fi
	@if [ -a dat/serpent_annotation_extended.bed ]; then :; else $(perlbin) src/generate_extended_annotation.pl dat/serpent_annotation_novel.bed dat/gencodev19_annotation_nonfiltered.bed > dat/serpent_annotation_extended.bed; fi
	@if [ -a dat/serpent_annotation_extended.gtf ]; then :; else $(perlbin) src/convert_extended_gtf.pl dat/serpent_annotation_novel.bed > dat/serpent_annotation_extended.gtf; fi

linesant:
	@mkdir -p dat
	@if [ -a dat/gencodev19_annotation_nonfiltered.bed ]; then echo "[LOG]   Non-filtered annotation exist"; fi
	@if [ -a dat/gencodev19_annotation_nonfiltered.bed ]; then :; else echo "[LOG]   Generating non-filtered annotation"; fi
	@if [ -a dat/gencodev19_annotation_nonfiltered.bed ]; then :; else $(perlbin) src/generate_gencode_annotation.pl dwn/$(gencodeg) dwn/$(gencodet) > dat/gencodev19_annotation_nonfiltered.bed; fi

a549:
	@mkdir -p dat
	@mkdir -p dat/a549
	@if [ -a dat/a549/annotation.bed ]; then echo "[LOG]   Clusters for A549 exist"; fi
	@if [ -a dat/a549/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for A549"; fi
	@if [ -a dat/a549/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate -a $(serpent_a_a) -o $(serpent_a_o) dat/a549/profiles.dat dat/a549/; fi

gm12878:
	@mkdir -p dat
	@mkdir -p dat/gm12878
	@if [ -a dat/gm12878/annotation.bed ]; then echo "[LOG]   Clusters for GM12878 exist"; fi
	@if [ -a dat/gm12878/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for GM12878"; fi
	@if [ -a dat/gm12878/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate -a $(serpent_a_a) -o $(serpent_a_o) dat/gm12878/profiles.dat dat/gm12878/; fi

helas3:
	@mkdir -p dat
	@mkdir -p dat/helas3
	@if [ -a dat/helas3/annotation.bed ]; then echo "[LOG]   Clusters for HeLa-S3 exist"; fi
	@if [ -a dat/helas3/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for HeLa-S3"; fi
	@if [ -a dat/helas3/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate -a $(serpent_a_a) -o $(serpent_a_o) dat/helas3/profiles.dat dat/helas3/; fi

hepg2:
	@mkdir -p dat
	@mkdir -p dat/hepg2
	@if [ -a dat/hepg2/annotation.bed ]; then echo "[LOG]   Clusters for HepG2 exist"; fi
	@if [ -a dat/hepg2/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for HepG2"; fi
	@if [ -a dat/hepg2/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate -a $(serpent_a_a) -o $(serpent_a_o) dat/hepg2/profiles.dat dat/hepg2/; fi

huvec:
	@mkdir -p dat
	@mkdir -p dat/huvec
	@if [ -a dat/huvec/annotation.bed ]; then echo "[LOG]   Clusters for HUVEC exist"; fi
	@if [ -a dat/huvec/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for HUVEC"; fi
	@if [ -a dat/huvec/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate -a $(serpent_a_a) -o $(serpent_a_o) dat/huvec/profiles.dat dat/huvec/; fi

imr90:
	@mkdir -p dat
	@mkdir -p dat/imr90
	@if [ -a dat/imr90/annotation.bed ]; then echo "[LOG]   Clusters for IMR90 exist"; fi
	@if [ -a dat/imr90/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for IMR90"; fi
	@if [ -a dat/imr90/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate -a $(serpent_a_a) -o $(serpent_a_o) dat/imr90/profiles.dat dat/imr90/; fi

k562:
	@mkdir -p dat
	@mkdir -p dat/k562
	@if [ -a dat/k562/annotation.bed ]; then echo "[LOG]   Clusters for K562 exist"; fi
	@if [ -a dat/k562/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for K562"; fi
	@if [ -a dat/k562/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate -a $(serpent_a_a) -o $(serpent_a_o) dat/k562/profiles.dat dat/k562/; fi

mcf7:
	@mkdir -p dat
	@mkdir -p dat/mcf7
	@if [ -a dat/mcf7/annotation.bed ]; then echo "[LOG]   Clusters for MCF-7 exist"; fi
	@if [ -a dat/mcf7/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for MCF-7"; fi
	@if [ -a dat/mcf7/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate -a $(serpent_a_a) -o $(serpent_a_o) dat/mcf7/profiles.dat dat/mcf7/; fi

nhek:
	@mkdir -p dat
	@mkdir -p dat/nhek
	@if [ -a dat/nhek/annotation.bed ]; then echo "[LOG]   Clusters for NHEK exist"; fi
	@if [ -a dat/nhek/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for NHEK"; fi
	@if [ -a dat/nhek/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate -a $(serpent_a_a) -o $(serpent_a_o) dat/nhek/profiles.dat dat/nhek/; fi

sknsh:
	@mkdir -p dat
	@mkdir -p dat/sknsh
	@if [ -a dat/sknsh/annotation.bed ]; then echo "[LOG]   Clusters for SK-N-SH exist"; fi
	@if [ -a dat/sknsh/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for SK-N-SH"; fi
	@if [ -a dat/sknsh/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate -a $(serpent_a_a) -o $(serpent_a_o) dat/sknsh/profiles.dat dat/sknsh/; fi

chromatin:
	@mkdir -p dat
	@mkdir -p dat/chromatin
	@mkdir -p tmp
	@if [ -a dat/chromatin/annotation.bed ]; then echo "[LOG]   Clusters for Chromatin exist"; fi
	@if [ -a dat/chromatin/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for Chromatin"; fi
	@if [ -a dat/chromatin/annotation.bed ]; then :; else cut -f1-6 $(serpent_a_a_c) > tmp/sae.bed; fi
	@if [ -a dat/chromatin/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate -a tmp/sae.bed -o $(serpent_a_o_c) dat/chromatin/profiles.dat dat/chromatin/; fi
	@rm -rf tmp

cytosol:
	@mkdir -p dat
	@mkdir -p dat/cytosol
	@mkdir -p tmp
	@if [ -a dat/cytosol/annotation.bed ]; then echo "[LOG]   Clusters for Cytosol exist"; fi
	@if [ -a dat/cytosol/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for Cytosol"; fi
	@if [ -a dat/cytosol/annotation.bed ]; then :; else cut -f1-6 $(serpent_a_a_c) > tmp/sae.bed; fi
	@if [ -a dat/cytosol/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate -a tmp/sae.bed -o $(serpent_a_o_c) dat/cytosol/profiles.dat dat/cytosol/; fi
	@rm -rf tmp

nucleolus:
	@mkdir -p dat
	@mkdir -p dat/nucleolus
	@mkdir -p tmp
	@if [ -a dat/nucleolus/annotation.bed ]; then echo "[LOG]   Clusters for Nucleolus exist"; fi
	@if [ -a dat/nucleolus/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for Nucleolus"; fi
	@if [ -a dat/nucleolus/annotation.bed ]; then :; else cut -f1-6 $(serpent_a_a_c) > tmp/sae.bed; fi
	@if [ -a dat/nucleolus/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate -a tmp/sae.bed -o $(serpent_a_o_c) dat/nucleolus/profiles.dat dat/nucleolus/; fi
	@rm -rf tmp

nucleoplasm:
	@mkdir -p dat
	@mkdir -p dat/nucleoplasm
	@mkdir -p tmp
	@if [ -a dat/nucleoplasm/annotation.bed ]; then echo "[LOG]   Clusters for Nucleoplasm exist"; fi
	@if [ -a dat/nucleoplasm/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for Nucleoplasm"; fi
	@if [ -a dat/nucleoplasm/annotation.bed ]; then :; else cut -f1-6 $(serpent_a_a_c) > tmp/sae.bed; fi
	@if [ -a dat/nucleoplasm/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate -a tmp/sae.bed -o $(serpent_a_o_c) dat/nucleoplasm/profiles.dat dat/nucleoplasm/; fi
	@rm -rf tmp

wild:
	@mkdir -p dat
	@mkdir -p dat/wild
	@if [ -a dat/wild/annotation.bed ]; then echo "[LOG]   Clusters for Wild-type exist"; fi
	@if [ -a dat/wild/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for Wild-type"; fi
	@if [ -a dat/wild/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate  -a $(serpent_a_a) -o $(serpent_a_o) dat/wild/profiles.dat dat/wild/; fi

dicer:
	@mkdir -p dat
	@mkdir -p dat/dicer
	@if [ -a dat/dicer/annotation.bed ]; then echo "[LOG]   Clusters for Dicer-KD exist"; fi
	@if [ -a dat/dicer/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for Dicer-KD"; fi
	@if [ -a dat/dicer/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate  -a $(serpent_a_a) -o $(serpent_a_o) dat/dicer/profiles.dat dat/dicer/; fi

drosha:
	@mkdir -p dat
	@mkdir -p dat/drosha
	@if [ -a dat/drosha/annotation.bed ]; then echo "[LOG]   Clusters for Drosha-KD exist"; fi
	@if [ -a dat/drosha/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for Drosha-KD"; fi
	@if [ -a dat/drosha/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate  -a $(serpent_a_a) -o $(serpent_a_o) dat/drosha/profiles.dat dat/drosha/; fi

bnmant:
	@mkdir -p dat
	@if [ -a dat/gencodev19_annotation_filtered.bed ]; then echo "[LOG]   Filtered annotation exist"; fi
	@if [ -a dat/gencodev19_annotation_filtered.bed ]; then :; else echo "[LOG]   Generating filtered annotation"; fi
	@if [ -a dat/gencodev19_annotation_filtered.bed ]; then :; else $(perlbin) src/generate_gencode_filtered-annotation.pl dwn/$(gencodeg) dwn/$(gencodet) > dat/gencodev19_annotation_filtered.bed; fi

bnm:
	@mkdir -p dat
	@mkdir -p dat/bnm
	@if [ -a dat/bnm/annotation.bed ]; then echo "[LOG]   Clusters for GSM769510 exist"; fi
	@if [ -a dat/bnm/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for GSM769510"; fi
	@if [ -a dat/bnm/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate -a $(serpent_a_a_bnm) -o $(serpent_a_o_bnm) dat/bnm/profiles.dat dat/bnm/; fi

dfpa549:
	@mkdir -p bnm
	@mkdir -p bnm/a549
	@if [ -a bnm/a549/annotation.bed ]; then echo "[LOG]   Clusters for A549 exist"; fi
	@if [ -a bnm/a549/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for A549"; fi
	@if [ -a bnm/a549/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate bnm/a549/profiles.dat bnm/a549/; fi

dfpag04450:
	@mkdir -p bnm
	@mkdir -p bnm/ag04450
	@if [ -a bnm/ag04450/annotation.bed ]; then echo "[LOG]   Clusters for AG04450 exist"; fi
	@if [ -a bnm/ag04450/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for AG04450"; fi
	@if [ -a bnm/ag04450/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate bnm/ag04450/profiles.dat bnm/ag04450/; fi

dfpbj:
	@mkdir -p bnm
	@mkdir -p bnm/bj
	@if [ -a bnm/bj/annotation.bed ]; then echo "[LOG]   Clusters for BJ exist"; fi
	@if [ -a bnm/bj/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for BJ"; fi
	@if [ -a bnm/bj/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate bnm/bj/profiles.dat bnm/bj/; fi

dfpgm12878:
	@mkdir -p bnm
	@mkdir -p bnm/gm12878
	@if [ -a bnm/gm12878/annotation.bed ]; then echo "[LOG]   Clusters for GM12878 exist"; fi
	@if [ -a bnm/gm12878/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for GM12878"; fi
	@if [ -a bnm/gm12878/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate bnm/gm12878/profiles.dat bnm/gm12878/; fi

dfph1hesc:
	@mkdir -p bnm
	@mkdir -p bnm/h1hesc
	@if [ -a bnm/h1hesc/annotation.bed ]; then echo "[LOG]   Clusters for h1-hESC exist"; fi
	@if [ -a bnm/h1hesc/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for h1-hESC"; fi
	@if [ -a bnm/h1hesc/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate bnm/h1hesc/profiles.dat bnm/h1hesc/; fi

dfphelas3:
	@mkdir -p bnm
	@mkdir -p bnm/helas3
	@if [ -a bnm/helas3/annotation.bed ]; then echo "[LOG]   Clusters for HeLa-S3 exist"; fi
	@if [ -a bnm/helas3/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for HeLa-S3"; fi
	@if [ -a bnm/helas3/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate bnm/helas3/profiles.dat bnm/helas3/; fi

dfphepg2:
	@mkdir -p bnm
	@mkdir -p bnm/hepg2
	@if [ -a bnm/hepg2/annotation.bed ]; then echo "[LOG]   Clusters for HepG2 exist"; fi
	@if [ -a bnm/hepg2/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for HepG2"; fi
	@if [ -a bnm/hepg2/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate bnm/hepg2/profiles.dat bnm/hepg2/; fi

dfpmcf7:
	@mkdir -p bnm
	@mkdir -p bnm/mcf7
	@if [ -a bnm/mcf7/annotation.bed ]; then echo "[LOG]   Clusters for MCF-7 exist"; fi
	@if [ -a bnm/mcf7/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for MCF-7"; fi
	@if [ -a bnm/mcf7/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate bnm/mcf7/profiles.dat bnm/mcf7/; fi

dfpsknsh:
	@mkdir -p bnm
	@mkdir -p bnm/sknsh
	@if [ -a bnm/sknsh/annotation.bed ]; then echo "[LOG]   Clusters for SK-N-SH exist"; fi
	@if [ -a bnm/sknsh/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for SK-N-SH"; fi
	@if [ -a bnm/sknsh/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate bnm/sknsh/profiles.dat bnm/sknsh/; fi

dfpnormal:
	@mkdir -p bnm
	@mkdir -p bnm/normal
	@if [ -a bnm/normal/annotation.bed ]; then echo "[LOG]   Clusters for GSE21279-normal exist"; fi
	@if [ -a bnm/normal/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for GSE21279-normal"; fi
	@if [ -a bnm/normal/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate bnm/normal/profiles.dat bnm/normal/; fi

dfptumour:
	@mkdir -p bnm
	@mkdir -p bnm/tumour
	@if [ -a bnm/tumour/annotation.bed ]; then echo "[LOG]   Clusters for GSE21279-tumour exist"; fi
	@if [ -a bnm/tumour/annotation.bed ]; then :; else echo "[LOG]   Executing annotator for GSE21279-tumour"; fi
	@if [ -a bnm/tumour/annotation.bed ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent annotate bnm/tumour/profiles.dat bnm/tumour/; fi
