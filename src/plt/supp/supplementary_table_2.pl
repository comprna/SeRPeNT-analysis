# ################################################
# supplementary_table_2.pl
#
# Characteristics of the ENCODE cell lines dataset
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ################################################

use strict;

# Usage:
#   perl supplementary_table_2.pl [lines|compartments]
# Example
#   perl supplementary_table_2.pl lines > fig/supp/supplementary_table_2.tab

# Constants
my @cell_names = ("A549", "GM12878", "HeLa-S3", "HepG2", "IMR90", "K562", "MCF-7", "NHEK", "SK-N-SH");
my @cell_tissue = ("Epithelium", "Blood", "Cervix", "Liver", "Lung", "Blood", "Breast", "Skin", "Brain");
my @cell_karyotype = ("Cancer", "Normal", "Cancer", "Cancer", "Normal", "Cancer", "Cancer", "Cancer", "Normal", "Cancer");
my @cell_reads = (101, 101, 36, 36, 36, 36, 36, 36, 101, 101, 36, 36, 101, 101, 36, 36, 101, 101);
my @cell_files = (
  "dwn/wgEncodeCshlShortRnaSeqA549NucleusShorttotalTapAlnRep3.bam", "dwn/wgEncodeCshlShortRnaSeqA549NucleusShorttotalTapAlnRep4.bam",
  "dwn/wgEncodeCshlShortRnaSeqGm12878NucleusShorttotalTapAlnRep1.bam", "dwn/wgEncodeCshlShortRnaSeqGm12878NucleusShorttotalTapAlnRep2.bam",
  "dwn/wgEncodeCshlShortRnaSeqHelas3NucleusShorttotalTapAlnRep1.bam", "dwn/wgEncodeCshlShortRnaSeqHelas3NucleusShorttotalTapAlnRep2.bam",
  "dwn/wgEncodeCshlShortRnaSeqHepg2NucleusShorttotalTapAlnRep1.bam", "dwn/wgEncodeCshlShortRnaSeqHepg2NucleusShorttotalTapAlnRep2.bam",
  "dwn/wgEncodeCshlShortRnaSeqImr90NucleusShorttotalTapAlnRep1.bam", "dwn/wgEncodeCshlShortRnaSeqImr90NucleusShorttotalTapAlnRep2.bam",
  "dwn/wgEncodeCshlShortRnaSeqK562NucleusShorttotalTapAlnRep1.bam", "dwn/wgEncodeCshlShortRnaSeqK562NucleusShorttotalTapAlnRep2.bam",
  "dwn/wgEncodeCshlShortRnaSeqMcf7NucleusShorttotalTapAlnRep3.bam", "dwn/wgEncodeCshlShortRnaSeqMcf7NucleusShorttotalTapAlnRep4.bam",
  "dwn/wgEncodeCshlShortRnaSeqNhekNucleusShorttotalTapAlnRep3.bam", "dwn/wgEncodeCshlShortRnaSeqNhekNucleusShorttotalTapAlnRep4.bam",
  "dwn/wgEncodeCshlShortRnaSeqSknshNucleusShorttotalTapAlnRep3.bam", "dwn/wgEncodeCshlShortRnaSeqSknshNucleusShorttotalTapAlnRep4.bam");
my @compartment_names = ("Chromatin", "Cytosol", "Nucleolus", "Nucleoplasm");
my @compartment_reads = (36, 36, 36, 36, 36, 36, 36, 36);
my @compartment_files = (
  "dwn/wgEncodeCshlShortRnaSeqK562ChromatinShorttotalTapAlnRep3.bam", "dwn/wgEncodeCshlShortRnaSeqK562ChromatinShorttotalTapAlnRep4.bam",
  "dwn/wgEncodeCshlShortRnaSeqK562CytosolShorttotalTapAlnRep1.bam", "dwn/wgEncodeCshlShortRnaSeqK562CytosolShorttotalTapAlnRep2.bam",
  "dwn/wgEncodeCshlShortRnaSeqK562NucleolusShorttotalTapAlnRep3.bam", "dwn/wgEncodeCshlShortRnaSeqK562NucleolusShorttotalTapAlnRep4.bam",
  "dwn/wgEncodeCshlShortRnaSeqK562NucleoplasmShorttotalTapAlnRep3.bam", "dwn/wgEncodeCshlShortRnaSeqK562NucleoplasmShorttotalTapAlnRep4.bam");

# Variable definition
my %mkdefs = ();   # var_id <-> var_value hashtable

# Read mks/makefile.defs
open(MKDEFS, " < mks/mkdefs.makefile");
while(<MKDEFS>) {
  chomp;
  next if (m/^$/);
  next if (m/#/);
  next if (!m/=/);

  my $line = $_;
  $line =~ s/\s+//g;
  my ($id, $vl) = split /=/, $line;
  $mkdefs{$id} = $vl;
}
close(MKDEFS);

# Set definitions in variables
my $samtools = $mkdefs{"samtoolsbin"};

# Parse command line
my $analysis = $ARGV[0];

# Parse number of mapped reads for cell line BAM files
if ($analysis eq "lines") {
  my $index = 0;
  for (my $i = 0; $i < scalar(@cell_files); $i++) {
    my $replicate = $i % 2;
    my $cell = $cell_names[$index];
    my $tissue = $cell_tissue[$index];
    my $karyotype = $cell_karyotype[$index];
    my $replicatet = $replicate + 1;
    my $reads = $cell_reads[$i];
    my $lines = `$samtools view -c -F 4 $cell_files[$i]`;
    chomp $lines;
    print STDOUT "$cell\t$tissue\t$karyotype\t$replicatet\t$lines\t$reads\n";
    $index++ if ($replicate > 0);
  }
}

# Parse number of mapped reads for compartment BAM files
if ($analysis eq "compartments") {
  $index = 0;
  for (my $i = 0; $i < scalar(@compartment_files); $i++) {
    my $replicate = $i % 2;
    my $comp = $compartment_names[$index];
    my $replicatet = $replicate + 1;
    my $reads = $compartment_reads[$i];
    my $lines = `$samtools view -c -F 4 $compartment_files[$i]`;
    chomp $lines;
    print STDOUT "$comp\t$replicatet\t$lines\t$reads\n";
    $index++ if ($replicate > 0);
  }
}
