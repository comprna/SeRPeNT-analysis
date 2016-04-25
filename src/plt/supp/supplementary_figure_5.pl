# ############################################################################
# supplementary_figure_5.pl
#
# Histogram of the number of cell lines for which a profile in the extended
# annotation is expressed
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ############################################################################

use strict;

# Usage:
#   perl supplementary_figure_5.pl novel_profiles
# Example
#   perl supplementary_figure_5.pl dat/serpent_annotation_novel.bed > tmp/inputR.tab

# Parse command line
my ($serpent_a_f) = $ARGV[0];

# Parse file
open(SER, " < $serpent_a_f");
while(<SER>) {
  chomp;
  my @a = split;
  my @cells = split /;/, $a[-1];
  print "NOVEL\t$a[4]\t", scalar(@cells), "\n";
}
close(SER);
