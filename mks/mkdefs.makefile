# ######################
# mkdefs.makefile
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ######################

# Software and file dependencies
perlbin = /soft/bin/perl
pythonbin = /softfedora/devel/python-2.7/bin/python
rbin = /soft/R/R-3.2.1/bin/R
bedtoolshome = /soft/bio/sequence/BEDTools-Version-2.16.2
samtoolsbin = /soft/bio/sequence/samtools-1.2/bin/samtools
sratoolkithome = /home/apages/tools/sratoolkit.2.5.7-centos_linux64
serpenthome = /home/apages/development/sdrnatools
starbin = /soft/bio/sequence/STAR-2.3.1z10/STAR
viennabin = /soft/bio/sequence/ViennaRNA-2.1.9/bin/RNAalifold
ggsearchbin = /home/apages/tools/fasta-36.3.5e/bin/ggsearch36
infernalbin = /softfedora/bio/sequence/infernal-1.1.1/bin
cutadaptbin = ~/.local/bin/cutadapt
rnastructurebin = /home/apages/tools/RNAstructure/exe

# Gencode annotation
gencodeg = gencode.v19.annotation.gtf
gencodet = gencode.v19.tRNAs.gtf
gencodel = gencode.v19.long_noncoding_RNAs.gtf
gencodegwww = ftp://ftp.sanger.ac.uk/pub/gencode/Gencode_human/release_19/$(gencodeg).gz
gencodetwww = ftp://ftp.sanger.ac.uk/pub/gencode/Gencode_human/release_19/$(gencodet).gz
gencodelwww = ftp://ftp.sanger.ac.uk/pub/gencode/Gencode_human/release_19/$(gencodel).gz

# BLAST partially non-redundant nucleotide database
blastnt = nt.fa
blastntgzip = nt.gz
blastntwww = ftp://ftp.ncbi.nlm.nih.gov/blast/db/FASTA/$(blastntgzip)

# Rfam cm-infernal database
rfam = Rfam.cm
rfamgzip = $(rfam).gz
rfamwww = ftp://ftp.ebi.ac.uk/pub/databases/Rfam/CURRENT/Rfam.cm.gz

# Human genome assembly hg19
hg19www = http://hgdownload.cse.ucsc.edu/goldenPath/hg19/bigZips/chromFa.tar.gz
hg19 = hg19.fa

# Base URL for ENCODE data
encodewww = http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlShortRnaSeq

# ENCODE cell lines data
a549r1 = wgEncodeCshlShortRnaSeqA549CellShorttotalTapAlnRep1V2.bam
a549r2 = wgEncodeCshlShortRnaSeqA549CellShorttotalTapAlnRep2V2.bam
ag04450r1 = wgEncodeCshlShortRnaSeqAg04450CellShorttotalTapAlnRep1.bam
ag04450r2 = wgEncodeCshlShortRnaSeqAg04450CellShorttotalTapAlnRep2.bam
bjr1 = wgEncodeCshlShortRnaSeqBjCellShorttotalTapAlnRep1.bam
bjr2 = wgEncodeCshlShortRnaSeqBjCellShorttotalTapAlnRep2.bam
gm12878r1 = wgEncodeCshlShortRnaSeqGm12878CellShorttotalTapAlnRep1.bam
gm12878r2 = wgEncodeCshlShortRnaSeqGm12878CellShorttotalTapAlnRep2.bam
h1hescr1 = wgEncodeCshlShortRnaSeqH1hescCellShorttotalTapAlnRep1.bam
h1hescr2 = wgEncodeCshlShortRnaSeqH1hescCellShorttotalTapAlnRep2.bam
helas3r1 = wgEncodeCshlShortRnaSeqHelas3CellShorttotalTapAlnRep1.bam
helas3r2 = wgEncodeCshlShortRnaSeqHelas3CellShorttotalTapAlnRep2.bam
hepg2r1 = wgEncodeCshlShortRnaSeqHepg2CellShorttotalTapAlnRep1.bam
hepg2r2 = wgEncodeCshlShortRnaSeqHepg2CellShorttotalTapAlnRep2.bam
imr90r1 = wgEncodeCshlShortRnaSeqImr90CellShorttotalTapAlnRep1.bam
imr90r2 = wgEncodeCshlShortRnaSeqImr90CellShorttotalTapAlnRep2.bam
k562r1 = wgEncodeCshlShortRnaSeqK562CellShorttotalTapAlnRep1.bam
k562r2 = wgEncodeCshlShortRnaSeqK562CellShorttotalTapAlnRep2.bam
mcf7r1 = wgEncodeCshlShortRnaSeqMcf7CellShorttotalTapAlnRep1V2.bam
mcf7r2 = wgEncodeCshlShortRnaSeqMcf7CellShorttotalTapAlnRep2V2.bam
nhekr1 = wgEncodeCshlShortRnaSeqNhekCellShorttotalTapAlnRep1.bam
nhekr2 = wgEncodeCshlShortRnaSeqNhekCellShorttotalTapAlnRep2.bam
sknshr1 = wgEncodeCshlShortRnaSeqSknshCellShorttotalTapAlnRep3.bam
sknshr2 = wgEncodeCshlShortRnaSeqSknshCellShorttotalTapAlnRep4.bam

# ENCODE compartments data
chromatinr1 = wgEncodeCshlShortRnaSeqK562ChromatinShorttotalTapAlnRep3.bam
chromatinr2 = wgEncodeCshlShortRnaSeqK562ChromatinShorttotalTapAlnRep4.bam
cytosolr1 = wgEncodeCshlShortRnaSeqK562CytosolShorttotalTapAlnRep1.bam
cytosolr2 = wgEncodeCshlShortRnaSeqK562CytosolShorttotalTapAlnRep2.bam
nucleolusr1 = wgEncodeCshlShortRnaSeqK562NucleolusShorttotalTapAlnRep3.bam
nucleolusr2 = wgEncodeCshlShortRnaSeqK562NucleolusShorttotalTapAlnRep4.bam
nucleoplasmr1 = wgEncodeCshlShortRnaSeqK562NucleoplasmShorttotalTapAlnRep3.bam
nucleoplasmr2 = wgEncodeCshlShortRnaSeqK562NucleoplasmShorttotalTapAlnRep4.bam

# GSM769510 data
bnmr1 = SRR326280

# GSE21279 data
dfpbnmn1 = SRR039611
dfpbnmn2 = SRR039612
dfpbnmn3 = SRR039613
dfpbnmt1 = SRR039619
dfpbnmt2 = SRR039621

# Primers for GSE21279 data
dfpbnmn15p = GTTCAGAGTTCTACAGTCCGACGATC
dfpbnmn13p = TCGTATGCCGTCTTCTGCTTGT
dfpbnmn25p = $(dfpbnmn15p)
dfpbnmn23p = $(dfpbnmn13p)
dfpbnmn35p = $(dfpbnmn15p)
dfpbnmn33p = $(dfpbnmn13p)
dfpbnmt15p = $(dfpbnmn15p)
dfpbnmt13p = $(dfpbnmn13p)
dfpbnmt25p = $(dfpbnmn15p)
dfpbnmt23p = $(dfpbnmn13p)

# GSE77989 data
wildr1 = SRR3174960
wildr2 = SRR3174961
droshar1 = SRR3174962
droshar2 = SRR3174963
exportinr1 = SRR3174965
exportinr2 = SRR3174966
dicerr1 = SRR3174967
dicerr2 = SRR3174968

# Primers for GSE77989 data
gse779895p = GTTCAGAGTTCTACAGTCCGACGATC
gse779893p = TGGAATTCTCGGGTGCCAAGG
