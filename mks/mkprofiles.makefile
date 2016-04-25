# ######################
# mkprofiles.makefile
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ######################

include mks/mkdefs.makefile
include mks/mkparams.makefile

# Set of rules for profile generation

lines: a549 gm12878 helas3 hepg2 imr90 k562 mcf7 nhek sknsh

compartments: chromatin cytosol nucleolus nucleoplasm

knockdown: wild dicer drosha

benchmarking: bnm

diffprocbnm: dfpa549 dfpag04450 dfpbj dfph1hesc dfphelas3 dfphepg2 dfpgm12878 dfpmcf7 dfpsknsh dfpnormal dfptumour 

a549:
	@mkdir -p dat
	@mkdir -p dat/a549
	@if [ -a dat/a549/profiles.dat ]; then echo "[LOG]   Profiles for A549 exist"; fi
	@if [ -a dat/a549/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for A549"; fi
	@if [ -a dat/a549/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f) -i $(serpent_p_i) -t $(serpent_p_t) -p $(serpent_p_p) dwn/$(a549r1) dwn/$(a549r2) dat/a549/; fi

gm12878:
	@mkdir -p dat
	@mkdir -p dat/gm12878
	@if [ -a dat/gm12878/profiles.dat ]; then echo "[LOG]   Profiles for GM12878 exist"; fi
	@if [ -a dat/gm12878/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for GM12878"; fi
	@if [ -a dat/gm12878/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f) -i $(serpent_p_i) -t $(serpent_p_t) -p $(serpent_p_p) dwn/$(gm12878r1) dwn/$(gm12878r2) dat/gm12878/; fi

helas3:
	@mkdir -p dat
	@mkdir -p dat/helas3
	@if [ -a dat/helas3/profiles.dat ]; then echo "[LOG]   Profiles for HeLa-S3 exist"; fi
	@if [ -a dat/helas3/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for HeLa-S3"; fi
	@if [ -a dat/helas3/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f) -i $(serpent_p_i) -t $(serpent_p_t) -p $(serpent_p_p) dwn/$(helas3r1) dwn/$(helas3r2) dat/helas3/; fi

hepg2:
	@mkdir -p dat
	@mkdir -p dat/hepg2
	@if [ -a dat/hepg2/profiles.dat ]; then echo "[LOG]   Profiles for HepG2 exist"; fi
	@if [ -a dat/hepg2/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for HepG2"; fi
	@if [ -a dat/hepg2/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f) -i $(serpent_p_i) -t $(serpent_p_t) -p $(serpent_p_p) dwn/$(hepg2r1) dwn/$(hepg2r2) dat/hepg2/; fi

huvec:
	@mkdir -p dat
	@mkdir -p dat/huvec
	@if [ -a dat/huvec/profiles.dat ]; then echo "[LOG]   Profiles for HUVEC exist"; fi
	@if [ -a dat/huvec/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for HUVEC"; fi
	@if [ -a dat/huvec/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f) -i $(serpent_p_i) -t $(serpent_p_t) -p $(serpent_p_p) dwn/$(huvecr1) dwn/$(huvecr2) dat/huvec/; fi

imr90:
	@mkdir -p dat
	@mkdir -p dat/imr90
	@if [ -a dat/imr90/profiles.dat ]; then echo "[LOG]   Profiles for IMR90 exist"; fi
	@if [ -a dat/imr90/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for IMR90"; fi
	@if [ -a dat/imr90/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f) -i $(serpent_p_i) -t $(serpent_p_t) -p $(serpent_p_p) dwn/$(imr90r1) dwn/$(imr90r2) dat/imr90/; fi

k562:
	@mkdir -p dat
	@mkdir -p dat/k562
	@if [ -a dat/k562/profiles.dat ]; then echo "[LOG]   Profiles for K562 exist"; fi
	@if [ -a dat/k562/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for K562"; fi
	@if [ -a dat/k562/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f) -i $(serpent_p_i) -t $(serpent_p_t) -p $(serpent_p_p) dwn/$(k562r1) dwn/$(k562r2) dat/k562/; fi

mcf7:
	@mkdir -p dat
	@mkdir -p dat/mcf7
	@if [ -a dat/mcf7/profiles.dat ]; then echo "[LOG]   Profiles for MCF-7 exist"; fi
	@if [ -a dat/mcf7/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for MCF-7"; fi
	@if [ -a dat/mcf7/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f) -i $(serpent_p_i) -t $(serpent_p_t) -p $(serpent_p_p) dwn/$(mcf7r1) dwn/$(mcf7r2) dat/mcf7/; fi

nhek:
	@mkdir -p dat
	@mkdir -p dat/nhek
	@if [ -a dat/nhek/profiles.dat ]; then echo "[LOG]   Profiles for NHEK exist"; fi
	@if [ -a dat/nhek/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for NHEK"; fi
	@if [ -a dat/nhek/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f) -i $(serpent_p_i) -t $(serpent_p_t) -p $(serpent_p_p) dwn/$(nhekr1) dwn/$(nhekr2) dat/nhek/; fi

sknsh:
	@mkdir -p dat
	@mkdir -p dat/sknsh
	@if [ -a dat/sknsh/profiles.dat ]; then echo "[LOG]   Profiles for SK-N-SH exist"; fi
	@if [ -a dat/sknsh/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for SK-N-SH"; fi
	@if [ -a dat/sknsh/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f) -i $(serpent_p_i) -t $(serpent_p_t) -p $(serpent_p_p) dwn/$(sknshr1) dwn/$(sknshr2) dat/sknsh/; fi

chromatin:
	@mkdir -p dat
	@mkdir -p dat/chromatin
	@if [ -a dat/chromatin/profiles.dat ]; then echo "[LOG]   Profiles for Chromatin exist"; fi
	@if [ -a dat/chromatin/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for Chromatin"; fi
	@if [ -a dat/chromatin/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f) -i $(serpent_p_i) -t $(serpent_p_t) -p $(serpent_p_p) dwn/$(chromatinr1) dwn/$(chromatinr2) dat/chromatin/; fi

cytosol:
	@mkdir -p dat
	@mkdir -p dat/cytosol
	@if [ -a dat/cytosol/profiles.dat ]; then echo "[LOG]   Profiles for Cytosol exist"; fi
	@if [ -a dat/cytosol/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for Cytosol"; fi
	@if [ -a dat/cytosol/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f) -i $(serpent_p_i) -t $(serpent_p_t) -p $(serpent_p_p) dwn/$(cytosolr1) dwn/$(cytosolr2) dat/cytosol/; fi

nucleolus:
	@mkdir -p dat
	@mkdir -p dat/nucleolus
	@if [ -a dat/nucleolus/profiles.dat ]; then echo "[LOG]   Profiles for Nucleolus exist"; fi
	@if [ -a dat/nucleolus/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for Nucleolus"; fi
	@if [ -a dat/nucleolus/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f) -i $(serpent_p_i) -t $(serpent_p_t) -p $(serpent_p_p) dwn/$(nucleolusr1) dwn/$(nucleolusr2) dat/nucleolus/; fi

nucleoplasm:
	@mkdir -p dat
	@mkdir -p dat/nucleoplasm
	@if [ -a dat/nucleoplasm/profiles.dat ]; then echo "[LOG]   Profiles for Nucleoplasm exist"; fi
	@if [ -a dat/nucleoplasm/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for Nucleoplasm"; fi
	@if [ -a dat/nucleoplasm/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f) -i $(serpent_p_i) -t $(serpent_p_t) -p $(serpent_p_p) dwn/$(nucleoplasmr1) dwn/$(nucleoplasmr2) dat/nucleoplasm/; fi

wild:
	@mkdir -p dat
	@mkdir -p dat/wild
	@if [ -a dat/wild/profiles.dat ]; then echo "[LOG]   Profiles for Wil-type exist"; fi
	@if [ -a dat/wild/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for Wild-type"; fi
	@if [ -a dat/wild/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f_kd) -r $(serpent_p_r_kd) -i $(serpent_p_i_kd) -t $(serpent_p_t_kd) -p $(serpent_p_p_kd) dat/wild/$(wildr1).bam dat/wild/$(wildr2).bam dat/wild/; fi

dicer:
	@mkdir -p dat
	@mkdir -p dat/dicer
	@if [ -a dat/dicer/profiles.dat ]; then echo "[LOG]   Profiles for Dicer-KD exist"; fi
	@if [ -a dat/dicer/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for Dicer-KD"; fi
	@if [ -a dat/dicer/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f_kd) -r $(serpent_p_r_kd) -i $(serpent_p_i_kd) -t $(serpent_p_t_kd) -p $(serpent_p_p_kd) dat/dicer/$(dicerr1).bam dat/dicer/$(dicerr2).bam dat/dicer/; fi

drosha:
	@mkdir -p dat
	@mkdir -p dat/drosha
	@if [ -a dat/drosha/profiles.dat ]; then echo "[LOG]   Profiles for Drosha-KD exist"; fi
	@if [ -a dat/drosha/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for Drosha-KD"; fi
	@if [ -a dat/drosha/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f_kd) -r $(serpent_p_r_kd) -i $(serpent_p_i_kd) -t $(serpent_p_t_kd) -p $(serpent_p_p_kd) dat/drosha/$(droshar1).bam dat/drosha/$(droshar2).bam dat/drosha/; fi

bnm:
	@mkdir -p dat
	@mkdir -p dat/bnm
	@if [ -a dat/bnm/profiles.dat ]; then echo "[LOG]   Profiles for GSM769510 exist"; fi
	@if [ -a dat/bnm/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for GSM769510"; fi
	@if [ -a dat/bnm/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f_bnm) -r $(serpent_p_r_bnm) -i $(serpent_p_i_bnm) -t $(serpent_p_t_bnm) -p $(serpent_p_p_bnm) dat/bnm/$(bnmr1).bam dat/bnm/$(bnmr1).bam dat/bnm/; fi

dfpa549:
	@mkdir -p bnm
	@mkdir -p bnm/a549
	@if [ -a bnm/a549/profiles.dat ]; then echo "[LOG]   Profiles for A549 exist"; fi
	@if [ -a bnm/a549/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for A549"; fi
	@if [ -a bnm/a549/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f_dpb) -i $(serpent_p_i_dpb) -t $(serpent_p_t_dpb) -p $(serpent_p_p_dpb) dwn/$(a549r1) dwn/$(a549r2) bnm/a549/; fi

dfpag04450:
	@mkdir -p bnm
	@mkdir -p bnm/ag04450
	@if [ -a bnm/ag04450/profiles.dat ]; then echo "[LOG]   Profiles for AG04450 exist"; fi
	@if [ -a bnm/ag04450/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for AG04450"; fi
	@if [ -a bnm/ag04450/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f_dpb) -i $(serpent_p_i_dpb) -t $(serpent_p_t_dpb) -p $(serpent_p_p_dpb) dwn/$(ag04450r1) dwn/$(ag04450r2) bnm/ag04450/; fi

dfpbj:
	@mkdir -p bnm
	@mkdir -p bnm/bj
	@if [ -a bnm/bj/profiles.dat ]; then echo "[LOG]   Profiles for BJ exist"; fi
	@if [ -a bnm/bj/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for BJ"; fi
	@if [ -a bnm/bj/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f_dpb) -i $(serpent_p_i_dpb) -t $(serpent_p_t_dpb) -p $(serpent_p_p_dpb) dwn/$(bjr1) dwn/$(bjr2) bnm/bj/; fi

dfpgm12878:
	@mkdir -p bnm
	@mkdir -p bnm/gm12878
	@if [ -a bnm/gm12878/profiles.dat ]; then echo "[LOG]   Profiles for GM12878 exist"; fi
	@if [ -a bnm/gm12878/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for GM12878"; fi
	@if [ -a bnm/gm12878/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f_dpb) -i $(serpent_p_i_dpb) -t $(serpent_p_t_dpb) -p $(serpent_p_p_dpb) dwn/$(gm12878r1) dwn/$(gm12878r2) bnm/gm12878/; fi

dfph1hesc:
	@mkdir -p bnm
	@mkdir -p bnm/h1hesc
	@if [ -a bnm/h1hesc/profiles.dat ]; then echo "[LOG]   Profiles for h1-hESC exist"; fi
	@if [ -a bnm/h1hesc/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for h1-hESC"; fi
	@if [ -a bnm/h1hesc/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f_dpb) -i $(serpent_p_i_dpb) -t $(serpent_p_t_dpb) -p $(serpent_p_p_dpb) dwn/$(h1hescr1) dwn/$(h1hescr2) bnm/h1hesc/; fi

dfphelas3:
	@mkdir -p bnm
	@mkdir -p bnm/helas3
	@if [ -a bnm/helas3/profiles.dat ]; then echo "[LOG]   Profiles for HeLa-S3 exist"; fi
	@if [ -a bnm/helas3/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for HeLa-S3"; fi
	@if [ -a bnm/helas3/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f_dpb) -i $(serpent_p_i_dpb) -t $(serpent_p_t_dpb) -p $(serpent_p_p_dpb) dwn/$(helas3r1) dwn/$(helas3r2) bnm/helas3/; fi

dfphepg2:
	@mkdir -p bnm
	@mkdir -p bnm/hepg2
	@if [ -a bnm/hepg2/profiles.dat ]; then echo "[LOG]   Profiles for HepG2 exist"; fi
	@if [ -a bnm/hepg2/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for HepG2"; fi
	@if [ -a bnm/hepg2/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f_dpb) -i $(serpent_p_i_dpb) -t $(serpent_p_t_dpb) -p $(serpent_p_p_dpb) dwn/$(hepg2r1) dwn/$(hepg2r2) bnm/hepg2/; fi

dfpmcf7:
	@mkdir -p bnm
	@mkdir -p bnm/mcf7
	@if [ -a bnm/mcf7/profiles.dat ]; then echo "[LOG]   Profiles for MCF-7 exist"; fi
	@if [ -a bnm/mcf7/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for MCF-7"; fi
	@if [ -a bnm/mcf7/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f_dpb) -i $(serpent_p_i_dpb) -t $(serpent_p_t_dpb) -p $(serpent_p_p_dpb) dwn/$(mcf7r1) dwn/$(mcf7r2) bnm/mcf7/; fi

dfpsknsh:
	@mkdir -p bnm
	@mkdir -p bnm/sknsh
	@if [ -a bnm/sknsh/profiles.dat ]; then echo "[LOG]   Profiles for SK-N-SH exist"; fi
	@if [ -a bnm/sknsh/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for SK-N-SH"; fi
	@if [ -a bnm/sknsh/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f_dpb) -i $(serpent_p_i_dpb) -t $(serpent_p_t_dpb) -p $(serpent_p_p_dpb) dwn/$(sknshr1) dwn/$(sknshr2) bnm/sknsh/; fi

dfpnormal:
	@mkdir -p bnm
	@mkdir -p bnm/normal
	@if [ -a bnm/normal/profiles.dat ]; then echo "[LOG]   Profiles for GSE21279-normal exist"; fi
	@if [ -a bnm/normal/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for GSE21279-normal"; fi
	@if [ -a bnm/normal/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f_dpb) -r $(serpent_p_r_dpb) -i $(serpent_p_i_dpb) -t $(serpent_p_t_dpb) -p $(serpent_p_p_dpb) bnm/normal/$(dfpbnmn1).bam bnm/normal/$(dfpbnmn2).bam bnm/normal/$(dfpbnmn3).bam bnm/normal/; fi

dfptumour:
	@mkdir -p bnm
	@mkdir -p bnm/tumour
	@if [ -a bnm/tumour/profiles.dat ]; then echo "[LOG]   Profiles for GSE21279-tumour exist"; fi
	@if [ -a bnm/tumour/profiles.dat ]; then :; else echo "[LOG]   Executing profiler for GSE21279-tumour"; fi
	@if [ -a bnm/tumour/profiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent profiles -f $(serpent_p_f_dpb) -r $(serpent_p_r_dpb) -i $(serpent_p_i_dpb) -t $(serpent_p_t_dpb) -p $(serpent_p_p_dpb) bnm/tumour/$(dfpbnmt1).bam bnm/tumour/$(dfpbnmt2).bam bnm/tumour/; fi
