# ######################
# mkserpent diffproc.makefile
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ######################

include mks/mkdefs.makefile
include mks/mkparams.makefile

# Set of rules for differential processing in compartments

compartments: chvscy chvsno chvsnp cyvsno cyvsnp novsnp

diffprocbnm: a549vsmcf7 a549vssknsh mcf7vssknsh ag04450vsbj ag04450vsgm12878 ag04450vsh1hesc ag04450vshelas3 ag04450vshepg2 bjvsgm12878 bjvsh1hesc bjvshelas3 bjvshepg2 gm12878vsh1hesc gm12878vshelas3 gm12878vshepg2 h1hescvshelas3 h1hescvshepg2 helas3vshepg2 normalvstumour

chvscy:
	@mkdir -p dfp
	@mkdir -p dfp/chvscy
	@if [ -a dfp/chvscy/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between chromatin and cytosol exist"; fi
	@if [ -a dfp/chvscy/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between chromatin and cytosol"; fi
	@if [ -a dfp/chvscy/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) dat/chromatin/profiles.dat dat/chromatin/annotation.bed dat/cytosol/profiles.dat dat/cytosol/annotation.bed dfp/chvscy/; fi

chvsno:
	@mkdir -p dfp
	@mkdir -p dfp/chvsno
	@if [ -a dfp/chvsno/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between chromatin and nucleolus exist"; fi
	@if [ -a dfp/chvsno/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between chromatin and nucleolus"; fi
	@if [ -a dfp/chvsno/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) dat/chromatin/profiles.dat dat/chromatin/annotation.bed dat/nucleolus/profiles.dat dat/nucleolus/annotation.bed dfp/chvsno/; fi

chvsnp:
	@mkdir -p dfp
	@mkdir -p dfp/chvsnp
	@if [ -a dfp/chvsnp/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between chromatin and nucleoplasm exist"; fi
	@if [ -a dfp/chvsnp/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between chromatin and nucleoplasm"; fi
	@if [ -a dfp/chvsnp/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) dat/chromatin/profiles.dat dat/chromatin/annotation.bed dat/nucleoplasm/profiles.dat dat/nucleoplasm/annotation.bed dfp/chvsnp/; fi

cyvsno:
	@mkdir -p dfp
	@mkdir -p dfp/cyvsno
	@if [ -a dfp/cyvsno/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between cytosol and nucleolus exist"; fi
	@if [ -a dfp/cyvsno/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between cytosol and nucleolus"; fi
	@if [ -a dfp/cyvsno/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) dat/cytosol/profiles.dat dat/cytosol/annotation.bed dat/nucleolus/profiles.dat dat/nucleolus/annotation.bed dfp/cyvsno/; fi

cyvsnp:
	@mkdir -p dfp
	@mkdir -p dfp/cyvsnp
	@if [ -a dfp/cyvsnp/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between cytosol and nucleoplasm exist"; fi
	@if [ -a dfp/cyvsnp/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between cytosol and nucleoplasm"; fi
	@if [ -a dfp/cyvsnp/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) dat/cytosol/profiles.dat dat/cytosol/annotation.bed dat/nucleoplasm/profiles.dat dat/nucleoplasm/annotation.bed dfp/cyvsnp/; fi

novsnp:
	@mkdir -p dfp
	@mkdir -p dfp/novsnp
	@if [ -a dfp/novsnp/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between nucleolus and nucleoplasm exist"; fi
	@if [ -a dfp/novsnp/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between nucleolus and nucleoplasm"; fi
	@if [ -a dfp/novsnp/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) dat/nucleolus/profiles.dat dat/nucleolus/annotation.bed dat/nucleoplasm/profiles.dat dat/nucleoplasm/annotation.bed dfp/novsnp/; fi

a549vsmcf7:
	@mkdir -p dfp
	@mkdir -p dfp/a549vsmcf7
	@if [ -a dfp/a549vsmcf7/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between a549 and mcf7 exist"; fi
	@if [ -a dfp/a549vsmcf7/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between a549 and mcf7"; fi
	@if [ -a dfp/a549vsmcf7/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) bnm/a549/profiles.dat bnm/a549/annotation.bed bnm/mcf7/profiles.dat bnm/mcf7/annotation.bed dfp/a549vsmcf7/; fi

a549vssknsh:
	@mkdir -p dfp
	@mkdir -p dfp/a549vssknsh
	@if [ -a dfp/a549vssknsh/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between a549 and sknsh exist"; fi
	@if [ -a dfp/a549vssknsh/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between a549 and sknsh"; fi
	@if [ -a dfp/a549vssknsh/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) bnm/a549/profiles.dat bnm/a549/annotation.bed bnm/sknsh/profiles.dat bnm/sknsh/annotation.bed dfp/a549vssknsh/; fi

mcf7vssknsh:
	@mkdir -p dfp
	@mkdir -p dfp/mcf7vssknsh
	@if [ -a dfp/mcf7vssknsh/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between mcf7 and sknsh exist"; fi
	@if [ -a dfp/mcf7vssknsh/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between mcf7 and sknsh"; fi
	@if [ -a dfp/mcf7vssknsh/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) bnm/mcf7/profiles.dat bnm/mcf7/annotation.bed bnm/sknsh/profiles.dat bnm/sknsh/annotation.bed dfp/mcf7vssknsh/; fi

ag04450vsbj:
	@mkdir -p dfp
	@mkdir -p dfp/ag04450vsbj
	@if [ -a dfp/ag04450vsbj/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between ag04450 and bj exist"; fi
	@if [ -a dfp/ag04450vsbj/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between ag04450 and bj"; fi
	@if [ -a dfp/ag04450vsbj/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) bnm/ag04450/profiles.dat bnm/ag04450/annotation.bed bnm/bj/profiles.dat bnm/bj/annotation.bed dfp/ag04450vsbj/; fi

ag04450vsgm12878:
	@mkdir -p dfp
	@mkdir -p dfp/ag04450vsgm12878
	@if [ -a dfp/ag04450vsgm12878/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between ag04450 and gm12878 exist"; fi
	@if [ -a dfp/ag04450vsgm12878/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between ag04450 and gm12878"; fi
	@if [ -a dfp/ag04450vsgm12878/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) bnm/ag04450/profiles.dat bnm/ag04450/annotation.bed bnm/gm12878/profiles.dat bnm/gm12878/annotation.bed dfp/ag04450vsgm12878/; fi

ag04450vsh1hesc:
	@mkdir -p dfp
	@mkdir -p dfp/ag04450vsh1hesc
	@if [ -a dfp/ag04450vsh1hesc/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between ag04450 and h1hesc exist"; fi
	@if [ -a dfp/ag04450vsh1hesc/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between ag04450 and h1hesc"; fi
	@if [ -a dfp/ag04450vsh1hesc/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) bnm/ag04450/profiles.dat bnm/ag04450/annotation.bed bnm/h1hesc/profiles.dat bnm/h1hesc/annotation.bed dfp/ag04450vsh1hesc/; fi

ag04450vshelas3:
	@mkdir -p dfp
	@mkdir -p dfp/ag04450vshelas3
	@if [ -a dfp/ag04450vshelas3/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between ag04450 and helas3 exist"; fi
	@if [ -a dfp/ag04450vshelas3/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between ag04450 and helas3"; fi
	@if [ -a dfp/ag04450vshelas3/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) bnm/ag04450/profiles.dat bnm/ag04450/annotation.bed bnm/helas3/profiles.dat bnm/helas3/annotation.bed dfp/ag04450vshelas3/; fi

ag04450vshepg2:
	@mkdir -p dfp
	@mkdir -p dfp/ag04450vshepg2
	@if [ -a dfp/ag04450vshepg2/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between ag04450 and hepg2 exist"; fi
	@if [ -a dfp/ag04450vshepg2/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between ag04450 and hepg2"; fi
	@if [ -a dfp/ag04450vshepg2/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) bnm/ag04450/profiles.dat bnm/ag04450/annotation.bed bnm/hepg2/profiles.dat bnm/hepg2/annotation.bed dfp/ag04450vshepg2/; fi

bjvsgm12878:
	@mkdir -p dfp
	@mkdir -p dfp/bjvsgm12878
	@if [ -a dfp/bjvsgm12878/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between bj and gm12878 exist"; fi
	@if [ -a dfp/bjvsgm12878/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between bj and gm12878"; fi
	@if [ -a dfp/bjvsgm12878/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) bnm/bj/profiles.dat bnm/bj/annotation.bed bnm/gm12878/profiles.dat bnm/gm12878/annotation.bed dfp/bjvsgm12878/; fi

bjvsh1hesc:
	@mkdir -p dfp
	@mkdir -p dfp/bjvsh1hesc
	@if [ -a dfp/bjvsh1hesc/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between bj and h1hesc exist"; fi
	@if [ -a dfp/bjvsh1hesc/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between bj and h1hesc"; fi
	@if [ -a dfp/bjvsh1hesc/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) bnm/bj/profiles.dat bnm/bj/annotation.bed bnm/h1hesc/profiles.dat bnm/h1hesc/annotation.bed dfp/bjvsh1hesc/; fi

bjvshelas3:
	@mkdir -p dfp
	@mkdir -p dfp/bjvshelas3
	@if [ -a dfp/bjvshelas3/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between bj and helas3 exist"; fi
	@if [ -a dfp/bjvshelas3/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between bj and helas3"; fi
	@if [ -a dfp/bjvshelas3/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) bnm/bj/profiles.dat bnm/bj/annotation.bed bnm/helas3/profiles.dat bnm/helas3/annotation.bed dfp/bjvshelas3/; fi

bjvshepg2:
	@mkdir -p dfp
	@mkdir -p dfp/bjvshepg2
	@if [ -a dfp/bjvshepg2/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between bj and hepg2 exist"; fi
	@if [ -a dfp/bjvshepg2/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between bj and hepg2"; fi
	@if [ -a dfp/bjvshepg2/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) bnm/bj/profiles.dat bnm/bj/annotation.bed bnm/hepg2/profiles.dat bnm/hepg2/annotation.bed dfp/bjvshepg2/; fi

gm12878vsh1hesc:
	@mkdir -p dfp
	@mkdir -p dfp/gm12878vsh1hesc
	@if [ -a dfp/gm12878vsh1hesc/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between gm12878 and h1hesc exist"; fi
	@if [ -a dfp/gm12878vsh1hesc/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between gm12878 and h1hesc"; fi
	@if [ -a dfp/gm12878vsh1hesc/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) bnm/gm12878/profiles.dat bnm/gm12878/annotation.bed bnm/h1hesc/profiles.dat bnm/h1hesc/annotation.bed dfp/gm12878vsh1hesc/; fi

gm12878vshelas3:
	@mkdir -p dfp
	@mkdir -p dfp/gm12878vshelas3
	@if [ -a dfp/gm12878vshelas3/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between gm12878 and helas3 exist"; fi
	@if [ -a dfp/gm12878vshelas3/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between gm12878 and helas3"; fi
	@if [ -a dfp/gm12878vshelas3/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) bnm/gm12878/profiles.dat bnm/gm12878/annotation.bed bnm/helas3/profiles.dat bnm/helas3/annotation.bed dfp/gm12878vshelas3/; fi

gm12878vshepg2:
	@mkdir -p dfp
	@mkdir -p dfp/gm12878vshepg2
	@if [ -a dfp/gm12878vshepg2/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between gm12878 and hepg2 exist"; fi
	@if [ -a dfp/gm12878vshepg2/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between gm12878 and hepg2"; fi
	@if [ -a dfp/gm12878vshepg2/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) bnm/gm12878/profiles.dat bnm/gm12878/annotation.bed bnm/hepg2/profiles.dat bnm/hepg2/annotation.bed dfp/gm12878vshepg2/; fi

h1hescvshelas3:
	@mkdir -p dfp
	@mkdir -p dfp/h1hescvshelas3
	@if [ -a dfp/h1hescvshelas3/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between h1hesc and helas3 exist"; fi
	@if [ -a dfp/h1hescvshelas3/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between h1hesc and helas3"; fi
	@if [ -a dfp/h1hescvshelas3/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) bnm/h1hesc/profiles.dat bnm/h1hesc/annotation.bed bnm/helas3/profiles.dat bnm/helas3/annotation.bed dfp/h1hescvshelas3/; fi

h1hescvshepg2:
	@mkdir -p dfp
	@mkdir -p dfp/h1hescvshepg2
	@if [ -a dfp/h1hescvshepg2/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between h1hesc and hepg2 exist"; fi
	@if [ -a dfp/h1hescvshepg2/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between h1hesc and hepg2"; fi
	@if [ -a dfp/h1hescvshepg2/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) bnm/h1hesc/profiles.dat bnm/h1hesc/annotation.bed bnm/hepg2/profiles.dat bnm/hepg2/annotation.bed dfp/h1hescvshepg2/; fi

helas3vshepg2:
	@mkdir -p dfp
	@mkdir -p dfp/helas3vshepg2
	@if [ -a dfp/helas3vshepg2/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between helas3 and hepg2 exist"; fi
	@if [ -a dfp/helas3vshepg2/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between helas3 and hepg2"; fi
	@if [ -a dfp/helas3vshepg2/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) bnm/helas3/profiles.dat bnm/helas3/annotation.bed bnm/hepg2/profiles.dat bnm/hepg2/annotation.bed dfp/helas3vshepg2/; fi

normalvstumour:
	@mkdir -p dfp
	@mkdir -p dfp/normalvstumour
	@if [ -a dfp/normalvstumour/diffprofiles.dat ]; then echo "[LOG]   Differentially processed profiles between normal and tumour exist"; fi
	@if [ -a dfp/normalvstumour/diffprofiles.dat ]; then :; else echo "[LOG]   Calculating differentially processed profiles between normal and tumour"; fi
	@if [ -a dfp/normalvstumour/diffprofiles.dat ]; then :; else export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(serpenthome)/lib/; $(serpenthome)/bin/serpent diffproc -g $(serpent_d_g) bnm/normal/profiles.dat bnm/normal/annotation.bed bnm/tumour/profiles.dat bnm/tumour/annotation.bed dfp/normalvstumour/; fi
