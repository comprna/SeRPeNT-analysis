# ######################
# mkdownload.makefile
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ######################

include mks/mkdefs.makefile
include mks/mkparams.makefile


# Set of rules for data downloading

lines: a549 gm12878 helas3 hepg2 imr90 k562 mcf7 nhek sknsh

compartments: chromatin cytosol nucleolus nucleoplasm

knockdown: wild dicer drosha exportin

benchmarking: bnm

diffprocbnm: gm12878 sknsh mcf7 helas3 a549 h1hesc hepg2 ag04450 bj normal tumour

rfam:
	@mkdir -p dwn
	@if [ -a dwn/$(rfam) ]; then echo "[LOG]   Rfam CM database exists"; fi
	@if [ -a dwn/$(rfam) ]; then :; else echo "[LOG]   Downloading Rfam CM database"; fi
	@if [ -a dwn/$(rfam) ]; then :; else wget -P dwn/ $(rfamwww); fi
	@if [ -a dwn/$(rfam) ]; then :; else gunzip dwn/$(rfamgzip); fi

blastdb:
	@mkdir -p dwn
	@if [ -a dwn/$(blastnt) ]; then echo "[LOG]   BLAST nt database exists"; fi
	@if [ -a dwn/$(blastnt) ]; then :; else echo "[LOG]   Downloading BLAST nt database"; fi
	@if [ -a dwn/$(blastnt) ]; then :; else wget -P dwn/ $(blastntwww); fi
	@if [ -a dwn/$(blastnt) ]; then :; else gunzip dwn/$(blastntgzip); fi

annotation:
	@mkdir -p dwn
	@if [ -a dwn/$(gencodeg) ]; then echo "[LOG]   Gencode general annotation exists"; fi
	@if [ -a dwn/$(gencodeg) ]; then :; else echo "[LOG]   Downloading gencode general annotation"; fi
	@if [ -a dwn/$(gencodeg) ]; then :; else wget -P dwn/ $(gencodegwww); fi
	@if [ -a dwn/$(gencodeg) ]; then :; else gunzip dwn/$(gencodeg).gz; fi
	@if [ -a dwn/$(gencodet) ]; then echo "[LOG]   Gencode tRNA annotation exists"; fi
	@if [ -a dwn/$(gencodet) ]; then :; else echo "[LOG]   Downloading gencode tRNA annotation"; fi
	@if [ -a dwn/$(gencodet) ]; then :; else wget -P dwn/ $(gencodetwww); fi
	@if [ -a dwn/$(gencodet) ]; then :; else gunzip dwn/$(gencodet).gz; fi
	@if [ -a dwn/$(gencodel) ]; then echo "[LOG]   Gencode long non-coding RNA annotation exists"; fi
	@if [ -a dwn/$(gencodel) ]; then :; else echo "[LOG]   Downloading gencode long non-coding RNA annotation"; fi
	@if [ -a dwn/$(gencodel) ]; then :; else wget -P dwn/ $(gencodelwww); fi
	@if [ -a dwn/$(gencodel) ]; then :; else gunzip dwn/$(gencodel).gz; fi

genome:
	@mkdir -p dwn
	@if [ -a dwn/$(hg19) ]; then echo "[LOG]   Human genome assembly hg19 exists"; fi
	@if [ -a dwn/$(hg19) ]; then :; else echo "[LOG]   Downloading human genome assembly hg19"; fi
	@if [ -a dwn/$(hg19) ]; then :; else echo wget -P dwn/ $(hg19www); fi

a549:
	@mkdir -p dwn
	@if [ -a dwn/$(a549r1) ]; then echo "[LOG]   A549 - Replicate 1 exists"; fi
	@if [ -a dwn/$(a549r1) ]; then :; else echo "[LOG]   Downloading A549 - Replicate 1"; fi
	@if [ -a dwn/$(a549r1) ]; then :; else wget -P dwn/ $(encodewww)/$(a549r1); fi
	@if [ -a dwn/$(a549r2) ]; then echo "[LOG]   A549 - Replicate 2 exists"; fi
	@if [ -a dwn/$(a549r2) ]; then :; else echo "[LOG]   Downloading A549 - Replicate 2"; fi
	@if [ -a dwn/$(a549r2) ]; then :; else wget -P tmp/ $(encodewww)/$(a549r2); fi

gm12878:
	@mkdir -p dwn
	@if [ -a dwn/$(gm12878r1) ]; then echo "[LOG]   GM12878 - Replicate 1 exists"; fi
	@if [ -a dwn/$(gm12878r1) ]; then :; else echo "[LOG]   Downloading GM12878 - Replicate 1"; fi
	@if [ -a dwn/$(gm12878r1) ]; then :; else wget -P dwn/ $(encodewww)/$(gm12878r1); fi
	@if [ -a dwn/$(gm12878r2) ]; then echo "[LOG]   GM12878 - Replicate 2 exists"; fi
	@if [ -a dwn/$(gm12878r2) ]; then :; else echo "[LOG]   Downloading GM12878 - Replicate 2"; fi
	@if [ -a dwn/$(gm12878r2) ]; then :; else wget -P tmp/ $(encodewww)/$(gm12878r2); fi

helas3:
	@mkdir -p dwn
	@if [ -a dwn/$(helas3r1) ]; then echo "[LOG]   HeLa-S3 - Replicate 1 exists"; fi
	@if [ -a dwn/$(helas3r1) ]; then :; else echo "[LOG]   Downloading HeLa-S3 - Replicate 1"; fi
	@if [ -a dwn/$(helas3r1) ]; then :; else wget -P dwn/ $(encodewww)/$(helas3r1); fi
	@if [ -a dwn/$(helas3r2) ]; then echo "[LOG]   HeLa-S3 - Replicate 2 exists"; fi
	@if [ -a dwn/$(helas3r2) ]; then :; else echo "[LOG]   Downloading HeLa-S3 - Replicate 2"; fi
	@if [ -a dwn/$(helas3r2) ]; then :; else wget -P tmp/ $(encodewww)/$(helas3r2); fi

hepg2:
	@mkdir -p dwn
	@if [ -a dwn/$(hepg2r1) ]; then echo "[LOG]   HepG2 - Replicate 1 exists"; fi
	@if [ -a dwn/$(hepg2r1) ]; then :; else echo "[LOG]   Downloading HepG2 - Replicate 1"; fi
	@if [ -a dwn/$(hepg2r1) ]; then :; else wget -P dwn/ $(encodewww)/$(hepg2r1); fi
	@if [ -a dwn/$(hepg2r2) ]; then echo "[LOG]   HepG2 - Replicate 2 exists"; fi
	@if [ -a dwn/$(hepg2r2) ]; then :; else echo "[LOG]   Downloading HepG2 - Replicate 2"; fi
	@if [ -a dwn/$(hepg2r2) ]; then :; else wget -P tmp/ $(encodewww)/$(hepg2r2); fi

huvec:
	@mkdir -p dwn
	@if [ -a dwn/$(huvecr1) ]; then echo "[LOG]   HUVEC - Replicate 1 exists"; fi
	@if [ -a dwn/$(huvecr1) ]; then :; else echo "[LOG]   Downloading HUVEC - Replicate 1"; fi
	@if [ -a dwn/$(huvecr1) ]; then :; else wget -P dwn/ $(encodewww)/$(huvecr1); fi
	@if [ -a dwn/$(huvecr2) ]; then echo "[LOG]   HUVEC - Replicate 2 exists"; fi
	@if [ -a dwn/$(huvecr2) ]; then :; else echo "[LOG]   Downloading HUVEC - Replicate 2"; fi
	@if [ -a dwn/$(huvecr2) ]; then :; else wget -P tmp/ $(encodewww)/$(huvecr2); fi

imr90:
	@mkdir -p dwn
	@if [ -a dwn/$(imr90r1) ]; then echo "[LOG]   IMR90 - Replicate 1 exists"; fi
	@if [ -a dwn/$(imr90r1) ]; then :; else echo "[LOG]   Downloading IMR90 - Replicate 1"; fi
	@if [ -a dwn/$(imr90r1) ]; then :; else wget -P dwn/ $(encodewww)/$(imr90r1); fi
	@if [ -a dwn/$(imr90r2) ]; then echo "[LOG]   IMR90 - Replicate 2 exists"; fi
	@if [ -a dwn/$(imr90r2) ]; then :; else echo "[LOG]   Downloading IMR90 - Replicate 2"; fi
	@if [ -a dwn/$(imr90r2) ]; then :; else wget -P tmp/ $(encodewww)/$(imr90r2); fi

k562:
	@mkdir -p dwn
	@if [ -a dwn/$(k562r1) ]; then echo "[LOG]   K562 - Replicate 1 exists"; fi
	@if [ -a dwn/$(k562r1) ]; then :; else echo "[LOG]   Downloading K562 - Replicate 1"; fi
	@if [ -a dwn/$(k562r1) ]; then :; else wget -P dwn/ $(encodewww)/$(k562r1); fi
	@if [ -a dwn/$(k562r2) ]; then echo "[LOG]   K562 - Replicate 2 exists"; fi
	@if [ -a dwn/$(k562r2) ]; then :; else echo "[LOG]   Downloading K562 - Replicate 2"; fi
	@if [ -a dwn/$(k562r2) ]; then :; else wget -P tmp/ $(encodewww)/$(k562r2); fi

mcf7:
	@mkdir -p dwn
	@if [ -a dwn/$(mcf7r1) ]; then echo "[LOG]   MCF-7 - Replicate 1 exists"; fi
	@if [ -a dwn/$(mcf7r1) ]; then :; else echo "[LOG]   Downloading MCF-7 - Replicate 1"; fi
	@if [ -a dwn/$(mcf7r1) ]; then :; else wget -P dwn/ $(encodewww)/$(mcf7r1); fi
	@if [ -a dwn/$(mcf7r2) ]; then echo "[LOG]   MCF-7 - Replicate 2 exists"; fi
	@if [ -a dwn/$(mcf7r2) ]; then :; else echo "[LOG]   Downloading MCF-7 - Replicate 2"; fi
	@if [ -a dwn/$(mcf7r2) ]; then :; else wget -P tmp/ $(encodewww)/$(mcf7r2); fi

nhek:
	@mkdir -p dwn
	@if [ -a dwn/$(nhekr1) ]; then echo "[LOG]   NHEK - Replicate 1 exists"; fi
	@if [ -a dwn/$(nhekr1) ]; then :; else echo "[LOG]   Downloading NHEK - Replicate 1"; fi
	@if [ -a dwn/$(nhekr1) ]; then :; else wget -P dwn/ $(encodewww)/$(nhekr1); fi
	@if [ -a dwn/$(nhekr2) ]; then echo "[LOG]   NHEK - Replicate 2 exists"; fi
	@if [ -a dwn/$(nhekr2) ]; then :; else echo "[LOG]   Downloading NHEK - Replicate 2"; fi
	@if [ -a dwn/$(nhekr2) ]; then :; else wget -P tmp/ $(encodewww)/$(nhekr2); fi

sknsh:
	@mkdir -p dwn
	@if [ -a dwn/$(sknshr1) ]; then echo "[LOG]   SK-N-SH - Replicate 1 exists"; fi
	@if [ -a dwn/$(sknshr1) ]; then :; else echo "[LOG]   Downloading SK-N-SH - Replicate 1"; fi
	@if [ -a dwn/$(sknshr1) ]; then :; else wget -P dwn/ $(encodewww)/$(sknshr1); fi
	@if [ -a dwn/$(sknshr2) ]; then echo "[LOG]   SK-N-SH - Replicate 2 exists"; fi
	@if [ -a dwn/$(sknshr2) ]; then :; else echo "[LOG]   Downloading SK-N-SH - Replicate 2"; fi
	@if [ -a dwn/$(sknshr2) ]; then :; else wget -P tmp/ $(encodewww)/$(sknshr2); fi

ag04450:
	@mkdir -p dwn
	@if [ -a dwn/$(ag04450r1) ]; then echo "[LOG]   AG04450 - Replicate 1 exists"; fi
	@if [ -a dwn/$(ag04450r1) ]; then :; else echo "[LOG]   Downloading AG04450 - Replicate 1"; fi
	@if [ -a dwn/$(ag04450r1) ]; then :; else wget -P dwn/ $(encodewww)/$(ag04450r1); fi
	@if [ -a dwn/$(ag04450r2) ]; then echo "[LOG]   AG04450 - Replicate 2 exists"; fi
	@if [ -a dwn/$(ag04450r2) ]; then :; else echo "[LOG]   Downloading AG04450 - Replicate 2"; fi
	@if [ -a dwn/$(ag04450r2) ]; then :; else wget -P tmp/ $(encodewww)/$(ag04450r2); fi

bj:
	@mkdir -p dwn
	@if [ -a dwn/$(bjr1) ]; then echo "[LOG]   BJ - Replicate 1 exists"; fi
	@if [ -a dwn/$(bjr1) ]; then :; else echo "[LOG]   Downloading BJ - Replicate 1"; fi
	@if [ -a dwn/$(bjr1) ]; then :; else wget -P dwn/ $(encodewww)/$(bjr1); fi
	@if [ -a dwn/$(bjr2) ]; then echo "[LOG]   BJ - Replicate 2 exists"; fi
	@if [ -a dwn/$(bjr2) ]; then :; else echo "[LOG]   Downloading BJ - Replicate 2"; fi
	@if [ -a dwn/$(bjr2) ]; then :; else wget -P tmp/ $(encodewww)/$(bjr2); fi

h1hesc:
	@mkdir -p dwn
	@if [ -a dwn/$(h1hescr1) ]; then echo "[LOG]   h1hESC - Replicate 1 exists"; fi
	@if [ -a dwn/$(h1hescr1) ]; then :; else echo "[LOG]   Downloading h1hESC - Replicate 1"; fi
	@if [ -a dwn/$(h1hescr1) ]; then :; else wget -P dwn/ $(encodewww)/$(h1hescr1); fi
	@if [ -a dwn/$(h1hescr2) ]; then echo "[LOG]   h1hESC - Replicate 2 exists"; fi
	@if [ -a dwn/$(h1hescr2) ]; then :; else echo "[LOG]   Downloading h1hESC - Replicate 2"; fi
	@if [ -a dwn/$(h1hescr2) ]; then :; else wget -P tmp/ $(encodewww)/$(h1hescr2); fi

chromatin:
	@mkdir -p dwn
	@if [ -a dwn/$(chromatinr1) ]; then echo "[LOG]   Chromatin - Replicate 1 exists"; fi
	@if [ -a dwn/$(chromatinr1) ]; then :; else echo "[LOG]   Downloading Chromatin - Replicate 1"; fi
	@if [ -a dwn/$(chromatinr1) ]; then :; else wget -P dwn/ $(encodewww)/$(chromatinr1); fi
	@if [ -a dwn/$(chromatinr2) ]; then echo "[LOG]   Chromatin - Replicate 2 exists"; fi
	@if [ -a dwn/$(chromatinr2) ]; then :; else echo "[LOG]   Downloading Chromatin - Replicate 2"; fi
	@if [ -a dwn/$(chromatinr2) ]; then :; else wget -P tmp/ $(encodewww)/$(chromatinr2); fi

cytosol:
	@mkdir -p dwn
	@if [ -a dwn/$(cytosolr1) ]; then echo "[LOG]   Cytosol - Replicate 1 exists"; fi
	@if [ -a dwn/$(cytosolr1) ]; then :; else echo "[LOG]   Downloading Cytosol - Replicate 1"; fi
	@if [ -a dwn/$(cytosolr1) ]; then :; else wget -P dwn/ $(encodewww)/$(cytosolr1); fi
	@if [ -a dwn/$(cytosolr2) ]; then echo "[LOG]   Cytosol - Replicate 2 exists"; fi
	@if [ -a dwn/$(cytosolr2) ]; then :; else echo "[LOG]   Downloading Cytosol - Replicate 2"; fi
	@if [ -a dwn/$(cytosolr2) ]; then :; else wget -P tmp/ $(encodewww)/$(cytosolr2); fi

nucleolus:
	@mkdir -p dwn
	@if [ -a dwn/$(nucleolusr1) ]; then echo "[LOG]   Nucleolus - Replicate 1 exists"; fi
	@if [ -a dwn/$(nucleolusr1) ]; then :; else echo "[LOG]   Downloading Nucleolus - Replicate 1"; fi
	@if [ -a dwn/$(nucleolusr1) ]; then :; else wget -P dwn/ $(encodewww)/$(nucleolusr1); fi
	@if [ -a dwn/$(nucleolusr2) ]; then echo "[LOG]   Nucleolus - Replicate 2 exists"; fi
	@if [ -a dwn/$(nucleolusr2) ]; then :; else echo "[LOG]   Downloading Nucleolus - Replicate 2"; fi
	@if [ -a dwn/$(nucleolusr2) ]; then :; else wget -P tmp/ $(encodewww)/$(nucleolusr2); fi

nucleoplasm:
	@mkdir -p dwn
	@if [ -a dwn/$(nucleoplasmr1) ]; then echo "[LOG]   Nucleoplasm - Replicate 1 exists"; fi
	@if [ -a dwn/$(nucleoplasmr1) ]; then :; else echo "[LOG]   Downloading Nucleoplasm - Replicate 1"; fi
	@if [ -a dwn/$(nucleoplasmr1) ]; then :; else wget -P dwn/ $(encodewww)/$(nucleoplasmr1); fi
	@if [ -a dwn/$(nucleoplasmr2) ]; then echo "[LOG]   Nucleoplasm - Replicate 2 exists"; fi
	@if [ -a dwn/$(nucleoplasmr2) ]; then :; else echo "[LOG]   Downloading Nucleoplasm - Replicate 2"; fi
	@if [ -a dwn/$(nucleoplasmr2) ]; then :; else wget -P tmp/ $(encodewww)/$(nucleoplasmr2); fi

wild:
	@mkdir -p dwn
	@if [ -a dwn/$(wildr1).fastq ]; then echo "[LOG]   Control - Replicate 1 exists"; fi
	@if [ -a dwn/$(wildr1).fastq ]; then :; else echo "[LOG]   Downloading control - Replicate 1"; fi
	@if [ -a dwn/$(wildr1).fastq ]; then :; else $(sratoolkithome)/bin/fastq-dump -Z $(wildr1) > dwn/$(wildr1).fastq; fi
	@if [ -a dwn/$(wildr2).fastq ]; then echo "[LOG]   Control - Replicate 2 exists"; fi
	@if [ -a dwn/$(wildr2).fastq ]; then :; else echo "[LOG]   Downloading control - Replicate 2"; fi
	@if [ -a dwn/$(wildr2).fastq ]; then :; else $(sratoolkithome)/bin/fastq-dump -Z $(wildr2) > dwn/$(wildr2).fastq; fi

dicer:
	@mkdir -p dwn
	@if [ -a dwn/$(dicerr1).fastq ]; then echo "[LOG]   Dicer-KD - Replicate 1 exists"; fi
	@if [ -a dwn/$(dicerr1).fastq ]; then :; else echo "[LOG]   Downloading Dicer-KD - Replicate 1"; fi
	@if [ -a dwn/$(dicerr1).fastq ]; then :; else $(sratoolkithome)/bin/fastq-dump -Z $(dicerr1) > dwn/$(dicerr1).sra; fi
	@if [ -a dwn/$(dicerr2).fastq ]; then echo "[LOG]   Dicer-KD - Replicate 2 exists"; fi
	@if [ -a dwn/$(dicerr2).fastq ]; then :; else echo "[LOG]   Downloading Dicer-KD - Replicate 2"; fi
	@if [ -a dwn/$(dicerr2).fastq ]; then :; else $(sratoolkithome)/bin/fastq-dump -Z $(dicerr2) > dwn/$(dicerr2).sra; fi

drosha:
	@mkdir -p dwn
	@if [ -a dwn/$(droshar1).fastq ]; then echo "[LOG]   Drosha-KD - Replicate 1 exists"; fi
	@if [ -a dwn/$(droshar1).fastq ]; then :; else echo "[LOG]   Downloading Drosha-KD - Replicate 1"; fi
	@if [ -a dwn/$(droshar1).fastq ]; then :; else $(sratoolkithome)/bin/fastq-dump -Z $(droshar1) > dwn/$(droshar1).sra; fi
	@if [ -a dwn/$(droshar2).fastq ]; then echo "[LOG]   Drosha-KD - Replicate 2 exists"; fi
	@if [ -a dwn/$(droshar2).fastq ]; then :; else echo "[LOG]   Downloading Drosha-KD - Replicate 2"; fi
	@if [ -a dwn/$(droshar2).fastq ]; then :; else $(sratoolkithome)/bin/fastq-dump -Z $(droshar2) > dwn/$(droshar2).sra; fi

exportin:
	@mkdir -p dwn
	@if [ -a dwn/$(exportinr1).fastq ]; then echo "[LOG]   Exportin-5-KD - Replicate 1 exists"; fi
	@if [ -a dwn/$(exportinr1).fastq ]; then :; else echo "[LOG]   Downloading Exportin-5-KD - Replicate 1"; fi
	@if [ -a dwn/$(exportinr1).fastq ]; then :; else $(sratoolkithome)/bin/fastq-dump -Z $(exportinr1) > dwn/$(exportinr1).sra; fi
	@if [ -a dwn/$(exportinr2).fastq ]; then echo "[LOG]   Exportin-5-KD - Replicate 2 exists"; fi
	@if [ -a dwn/$(exportinr2).fastq ]; then :; else echo "[LOG]   Downloading Exportin-5-KD - Replicate 2"; fi
	@if [ -a dwn/$(exportinr2).fastq ]; then :; else $(sratoolkithome)/bin/fastq-dump -Z $(exportinr2) > dwn/$(exportinr2).sra; fi

bnm:
	@mkdir -p dwn
	@if [ -a dwn/$(bnmr1).fastq ]; then echo "[LOG]   GSM769510 - Replicate 1 exists"; fi
	@if [ -a dwn/$(bnmr1).fastq ]; then :; else echo "[LOG]   Downloading GSM769510 - Replicate 1"; fi
	@if [ -a dwn/$(bnmr1).fastq ]; then :; else $(sratoolkithome)/bin/fastq-dump -Z $(bnmr1) > dwn/$(bnmr1).sra; fi

normal:
	@mkdir -p dwn
	@if [ -a dwn/$(dfpbnmn1).fastq ]; then echo "[LOG]   Liver normal - Replicate 1 exists"; fi
	@if [ -a dwn/$(dfpbnmn1).fastq ]; then :; else echo "[LOG]   Downloading Liver normal - Replicate 1"; fi
	@if [ -a dwn/$(dfpbnmn1).fastq ]; then :; else $(sratoolkithome)/bin/fastq-dump -Z $(dfpbnmn1) > dwn/$(dfpbnmn1).sra; fi
	@if [ -a dwn/$(dfpbnmn2).fastq ]; then echo "[LOG]   Liver normal - Replicate 2 exists"; fi
	@if [ -a dwn/$(dfpbnmn2).fastq ]; then :; else echo "[LOG]   Downloading Liver normal - Replicate 2"; fi
	@if [ -a dwn/$(dfpbnmn2).fastq ]; then :; else $(sratoolkithome)/bin/fastq-dump -Z $(dfpbnmn2) > dwn/$(dfpbnmn2).sra; fi
	@if [ -a dwn/$(dfpbnmn3).fastq ]; then echo "[LOG]   Liver normal - Replicate 3 exists"; fi
	@if [ -a dwn/$(dfpbnmn3).fastq ]; then :; else echo "[LOG]   Downloading Liver normal - Replicate 3"; fi
	@if [ -a dwn/$(dfpbnmn3).fastq ]; then :; else $(sratoolkithome)/bin/fastq-dump -Z $(dfpbnmn3) > dwn/$(dfpbnmn3).sra; fi

tumour:
	@mkdir -p dwn
	@if [ -a dwn/$(dfpbnmt1).fastq ]; then echo "[LOG]   Liver tumour - Replicate 1 exists"; fi
	@if [ -a dwn/$(dfpbnmt1).fastq ]; then :; else echo "[LOG]   Downloading Liver tumour - Replicate 1"; fi
	@if [ -a dwn/$(dfpbnmt1).fastq ]; then :; else $(sratoolkithome)/bin/fastq-dump -Z $(dfpbnmt1) > dwn/$(dfpbnmt1).sra; fi
	@if [ -a dwn/$(dfpbnmt2).fastq ]; then echo "[LOG]   Liver tumour - Replicate 2 exists"; fi
	@if [ -a dwn/$(dfpbnmt2).fastq ]; then :; else echo "[LOG]   Downloading Liver tumour - Replicate 2"; fi
	@if [ -a dwn/$(dfpbnmt2).fastq ]; then :; else $(sratoolkithome)/bin/fastq-dump -Z $(dfpbnmt2) > dwn/$(dfpbnmt2).sra; fi
