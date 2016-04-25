# ######################
# mkvalidation.makefile
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ######################

include mks/mkdefs.makefile
include mks/mkparams.makefile

# Set of rules for novel profiles validation

knockdown: dicer drosha exportin

extended:
	@mkdir -p dat
	@if [ -a dat/serpent_annotation_novel.hits ]; then echo "[LOG]   Hits for predicted sequences in extended annotation exist"; fi
	@if [ -a dat/erpent_annotation_novel.hits ]; then :; else echo "[LOG]   Retrieving predicted sequences for profiles in extended annotation"; fi
	@if [ -a dat/serpent_annotation_novel.hits ]; then :; else $(perlbin) src/retrieve_predicted_sequences.pl dat/serpent_annotation_novel.bed dat/serpent_annotation_novel.fa $(mkvalidation_extension); fi
	@if [ -a dat/serpent_annotation_novel.hits ]; then :; else echo "[LOG]   Scanning hits for profiles in extended annotation"; fi
	@if [ -a dat/serpent_annotation_novel.hits ]; then :; else $(infernalbin)/cmscan --tblout dat/serpent_annotation_novel.hits dwn/$(rfam) dat/serpent_annotation_novel.fa; fi

dicer:
	@mkdir -p dat
	@mkdir -p dat/dicer
	@if [ -a dat/dicer/serpent_annotation_extended.deseq ]; then echo "[LOG]   Differential expression between control and DICER-Knockdown exist"; fi
	@if [ -a dat/dicer/serpent_annotation_extended.deseq ]; then :; else echo "[LOG]   Calculating differential expression between control and DICER-Knockdown"; fi
	@if [ -a dat/wild/$(wildr1)_unspliced.bam ]; then :; else $(samtoolsbin) view -h dat/wild/$(wildr1).bam | awk '$$6 !~ /N/ || $$1 ~ /^@/' | $(samtoolsbin) view -bS - > dat/wild/$(wildr1)_unspliced.bam; fi
	@if [ -a dat/wild/$(wildr2)_unspliced.bam ]; then :; else $(samtoolsbin) view -h dat/wild/$(wildr2).bam | awk '$$6 !~ /N/ || $$1 ~ /^@/' | $(samtoolsbin) view -bS - > dat/wild/$(wildr2)_unspliced.bam; fi
	@if [ -a dat/dicer/$(dicerr1)_unspliced.bam ]; then :; else $(samtoolsbin) view -h dat/dicer/$(dicerr1).bam | awk '$$6 !~ /N/ || $$1 ~ /^@/' | $(samtoolsbin) view -bS - > dat/dicer/$(dicerr1)_unspliced.bam; fi
	@if [ -a dat/dicer/$(dicerr2)_unspliced.bam ]; then :; else $(samtoolsbin) view -h dat/dicer/$(dicerr2).bam | awk '$$6 !~ /N/ || $$1 ~ /^@/' | $(samtoolsbin) view -bS - > dat/dicer/$(dicerr2)_unspliced.bam; fi
	@if [ -a dat/wild/$(wildr1).exp ]; then :; else $(bedtoolshome)/bin/intersectBed -s -bed -wb -abam dat/wild/$(wildr1)_unspliced.bam -b dat/serpent_annotation_extended.bed | cut -f13-18 | sort | uniq -c > dat/wild/$(wildr1).exp; fi
	@if [ -a dat/wild/$(wildr2).exp ]; then :; else $(bedtoolshome)/bin/intersectBed -s -bed -wb -abam dat/wild/$(wildr2)_unspliced.bam -b dat/serpent_annotation_extended.bed | cut -f13-18 | sort | uniq -c > dat/wild/$(wildr2).exp; fi
	@if [ -a dat/dicer/$(dicerr1).exp ]; then :; else $(bedtoolshome)/bin/intersectBed -s -bed -wb -abam dat/dicer/$(dicerr1)_unspliced.bam -b dat/serpent_annotation_extended.bed | cut -f13-18 | sort | uniq -c > dat/dicer/$(dicerr1).exp; fi
	@if [ -a dat/dicer/$(dicerr2).exp ]; then :; else $(bedtoolshome)/bin/intersectBed -s -bed -wb -abam dat/dicer/$(dicerr2)_unspliced.bam -b dat/serpent_annotation_extended.bed | cut -f13-18 | sort | uniq -c > dat/dicer/$(dicerr2).exp; fi
	@if [ -a dat/dicer/serpent_annotation_extended.exp ]; then :; else $(perlbin) src/calculate_differential_expression.pl dat/serpent_annotation_extended.bed dat/wild/$(wildr1).exp dat/wild/$(wildr2).exp dat/dicer/$(dicerr1).exp dat/dicer/$(dicerr2).exp > dat/dicer/serpent_annotation_extended.exp; fi
	@if [ -a dat/dicer/serpent_annotation_extended.deseq ]; then :; else $(rbin) --vanilla --args dat/dicer/serpent_annotation_extended.exp $(mkvalidation_pval) dat/dicer/serpent_annotation_extended.deseq < src/calculate_differential_expression.R > /dev/null; fi

drosha:
	@mkdir -p dat
	@mkdir -p dat/drosha
	@if [ -a dat/drosha/serpent_annotation_extended.deseq ]; then echo "[LOG]   Differential expression between control and DROSHA-Knockdown exist"; fi
	@if [ -a dat/drosha/serpent_annotation_extended.deseq ]; then :; else echo "[LOG]   Calculating differential expression between control and DROSHA-Knockdown"; fi
	@if [ -a dat/wild/$(wildr1)_unspliced.bam ]; then :; else $(samtoolsbin) view -h dat/wild/$(wildr1).bam | awk '$$6 !~ /N/ || $$1 ~ /^@/' | $(samtoolsbin) view -bS - > dat/wild/$(wildr1)_unspliced.bam; fi
	@if [ -a dat/wild/$(wildr2)_unspliced.bam ]; then :; else $(samtoolsbin) view -h dat/wild/$(wildr2).bam | awk '$$6 !~ /N/ || $$1 ~ /^@/' | $(samtoolsbin) view -bS - > dat/wild/$(wildr2)_unspliced.bam; fi
	@if [ -a dat/drosha/$(droshar1)_unspliced.bam ]; then :; else $(samtoolsbin) view -h dat/drosha/$(droshar1).bam | awk '$$6 !~ /N/ || $$1 ~ /^@/' | $(samtoolsbin) view -bS - > dat/drosha/$(droshar1)_unspliced.bam; fi
	@if [ -a dat/drosha/$(droshar2)_unspliced.bam ]; then :; else $(samtoolsbin) view -h dat/drosha/$(droshar2).bam | awk '$$6 !~ /N/ || $$1 ~ /^@/' | $(samtoolsbin) view -bS - > dat/drosha/$(droshar2)_unspliced.bam; fi
	@if [ -a dat/wild/$(wildr1).exp ]; then :; else $(bedtoolshome)/bin/intersectBed -s -bed -wb -abam dat/wild/$(wildr1)_unspliced.bam -b dat/serpent_annotation_extended.bed | cut -f13-18 | sort | uniq -c > dat/wild/$(wildr1).exp; fi
	@if [ -a dat/wild/$(wildr2).exp ]; then :; else $(bedtoolshome)/bin/intersectBed -s -bed -wb -abam dat/wild/$(wildr2)_unspliced.bam -b dat/serpent_annotation_extended.bed | cut -f13-18 | sort | uniq -c > dat/wild/$(wildr2).exp; fi
	@if [ -a dat/drosha/$(droshar1).exp ]; then :; else $(bedtoolshome)/bin/intersectBed -s -bed -wb -abam dat/drosha/$(droshar1)_unspliced.bam -b dat/serpent_annotation_extended.bed | cut -f13-18 | sort | uniq -c > dat/drosha/$(droshar1).exp; fi
	@if [ -a dat/drosha/$(droshar2).exp ]; then :; else $(bedtoolshome)/bin/intersectBed -s -bed -wb -abam dat/drosha/$(droshar2)_unspliced.bam -b dat/serpent_annotation_extended.bed | cut -f13-18 | sort | uniq -c > dat/drosha/$(droshar2).exp; fi
	@if [ -a dat/drosha/serpent_annotation_extended.exp ]; then :; else $(perlbin) src/calculate_differential_expression.pl dat/serpent_annotation_extended.bed dat/wild/$(wildr1).exp dat/wild/$(wildr2).exp dat/drosha/$(droshar1).exp dat/drosha/$(droshar2).exp > dat/drosha/serpent_annotation_extended.exp; fi
	@if [ -a dat/drosha/serpent_annotation_extended.deseq ]; then :; else $(rbin) --vanilla --args dat/drosha/serpent_annotation_extended.exp $(mkvalidation_pval) dat/drosha/serpent_annotation_extended.deseq < src/calculate_differential_expression.R > /dev/null; fi

exportin:
	@mkdir -p dat
	@mkdir -p dat/exportin
	@if [ -a dat/exportin/serpent_annotation_extended.deseq ]; then echo "[LOG]   Differential expression between control and XPO5-Knockdown exist"; fi
	@if [ -a dat/exportin/serpent_annotation_extended.deseq ]; then :; else echo "[LOG]   Calculating differential expression between control and XPO5-Knockdown"; fi
	@if [ -a dat/wild/$(wildr1)_unspliced.bam ]; then :; else $(samtoolsbin) view -h dat/wild/$(wildr1).bam | awk '$$6 !~ /N/ || $$1 ~ /^@/' | $(samtoolsbin) view -bS - > dat/wild/$(wildr1)_unspliced.bam; fi
	@if [ -a dat/wild/$(wildr2)_unspliced.bam ]; then :; else $(samtoolsbin) view -h dat/wild/$(wildr2).bam | awk '$$6 !~ /N/ || $$1 ~ /^@/' | $(samtoolsbin) view -bS - > dat/wild/$(wildr2)_unspliced.bam; fi
	@if [ -a dat/exportin/$(exportinr1)_unspliced.bam ]; then :; else $(samtoolsbin) view -h dat/exportin/$(exportinr1).bam | awk '$$6 !~ /N/ || $$1 ~ /^@/' | $(samtoolsbin) view -bS - > dat/exportin/$(exportinr1)_unspliced.bam; fi
	@if [ -a dat/exportin/$(exportinr2)_unspliced.bam ]; then :; else $(samtoolsbin) view -h dat/exportin/$(exportinr2).bam | awk '$$6 !~ /N/ || $$1 ~ /^@/' | $(samtoolsbin) view -bS - > dat/exportin/$(exportinr2)_unspliced.bam; fi
	@if [ -a dat/wild/$(wildr1).exp ]; then :; else $(bedtoolshome)/bin/intersectBed -s -bed -wb -abam dat/wild/$(wildr1)_unspliced.bam -b dat/serpent_annotation_extended.bed | cut -f13-18 | sort | uniq -c > dat/wild/$(wildr1).exp; fi
	@if [ -a dat/wild/$(wildr2).exp ]; then :; else $(bedtoolshome)/bin/intersectBed -s -bed -wb -abam dat/wild/$(wildr2)_unspliced.bam -b dat/serpent_annotation_extended.bed | cut -f13-18 | sort | uniq -c > dat/wild/$(wildr2).exp; fi
	@if [ -a dat/exportin/$(exportinr1).exp ]; then :; else $(bedtoolshome)/bin/intersectBed -s -bed -wb -abam dat/exportin/$(exportinr1)_unspliced.bam -b dat/serpent_annotation_extended.bed | cut -f13-18 | sort | uniq -c > dat/exportin/$(exportinr1).exp; fi
	@if [ -a dat/exportin/$(exportinr2).exp ]; then :; else $(bedtoolshome)/bin/intersectBed -s -bed -wb -abam dat/exportin/$(exportinr2)_unspliced.bam -b dat/serpent_annotation_extended.bed | cut -f13-18 | sort | uniq -c > dat/exportin/$(exportinr2).exp; fi
	@if [ -a dat/exportin/serpent_annotation_extended.exp ]; then :; else $(perlbin) src/calculate_differential_expression.pl dat/serpent_annotation_extended.bed dat/wild/$(wildr1).exp dat/wild/$(wildr2).exp dat/exportin/$(exportinr1).exp dat/exportin/$(exportinr2).exp > dat/exportin/serpent_annotation_extended.exp; fi
	@if [ -a dat/exportin/serpent_annotation_extended.deseq ]; then :; else $(rbin) --vanilla --args dat/exportin/serpent_annotation_extended.exp $(mkvalidation_pval) dat/exportin/serpent_annotation_extended.deseq < src/calculate_differential_expression.R > /dev/null; fi
