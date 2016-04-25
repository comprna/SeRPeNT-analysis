# #####################################################
# figure_4b.pl
#
# Volcano plot of snoRNAs in control vs Dicer-knockdown
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# #####################################################

use strict;

# Usage:
#   perl figure_4b.pl deseq_file cutoff
# Example
#   perl figure_4b.pl dat/dicer/serpent_annotation_extended.deseq > tmp/inputR.tab

# Parse command line
my ($serpent_a_f, $cutoff) = @ARGV;

# Parse file
open(SER, " < $serpent_a_f");
while(<SER>) {
  chomp;
  next if (m/baseMean/);
  
  my ($id, $baseMean, $log2FoldChange, $lfcSE, $stat, $pvalue, $padj) = split "\t";
  next if ($padj eq "NA");
  
  my ($chr, $sbp, $ebp, $bio, $ano) = split "#", $id;
  my $sig = "No";
  $sig = "Yes" if ($padj < $cutoff);
  my $ori = "Gencode";
  $ori = "SeRPeNT" if ($ano >= 0);

  print "$bio\t$ori\t$log2FoldChange\t$padj\t$sig\n";
}
close(SER);
