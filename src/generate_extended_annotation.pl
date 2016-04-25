# #################################################################################################
# generate_extended_annotation.pl
#
# Generates extended annotation by combining Gencode annotation and SeRPeNT annotation
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# #################################################################################################

use strict;

# Usage:
#   perl generate_extended_annotation.pl serpent_annotation gencode_annotation
# e.g.
#   perl generate_extended_annotation.pl dat/serpent_annotation_novel.bed dat/gencodev19_annotation_nonfiltered.bed > dat/serpent_annotation_extended.bed

# Parse command line
my ($serpent_a_f, $gencode_a_f) = @ARGV;

# Parse SeRPeNT annotation
my $result = `mkdir -p tmp`;
open(SER, " < $serpent_a_f");
open(OUT, " > tmp/annotation.bed");
while(<SER>) {
  chomp;
  my ($chr, $sbp, $ebp, $bio, $scr, $str, $lns) = split;
  print OUT "$chr\t$sbp\t$ebp\t$bio\t$scr\t$str\n";
}
close(SER);

# Parse GENCODE annotation
open(GCD, " < $gencode_a_f");
open(OUT, " >> tmp/annotation.bed");
while(<GCD>) {
  chomp;
  my ($chr, $sbp, $ebp, $bio, $scr, $str) = split;
  print OUT "$chr\t$sbp\t$ebp\t$bio\t-1\t$str\n";
}
close(GCD);

# Sort annotation
$result = `sort -k1,1 -k2,2n tmp/annotation.bed > tmp/sorted.bed`;

# Print extended annotation
open(EXT, " < tmp/sorted.bed");
while(<EXT>) {
  print "$_";
}
close(EXT);
$result = `rm -rf tmp/`;
