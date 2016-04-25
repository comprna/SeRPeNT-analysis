# ###########################################################################
# supplementary_figure_2.pl
#
# Empirical calculation of the fold-change cutoff for differential processing
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ###########################################################################

use strict;

# Usage:
#   perl supplementary_figure_2.pl
# Example
#   perl supplementary_figure_2.pl

# Constants
my @cells36  = ("ag04450", "bj", "gm12878", "h1hesc", "helas3", "hepg2");
my @cells101 = ("a549", "mcf7", "sknsh");

# Parse command line
my ($figa_f, $figb_f) = @ARGV;

# Parse 36 base pairs reads
for (my $i = 0; $i < scalar(@cells36) - 1; $i++) {
  my $c36a = $cells36[$i];
  for (my $j = $i + 1; $j < scalar(@cells36); $j++) {
    my $c36b = $cells36[$j];

    my $file = "dfp/$c36a"."vs$c36b/diffprofiles.dat";
    open(DFP, " < $file");
    while(<DFP>) {
      chomp;
      my @a = split;
      if ($a[0] ne "NA" and $a[1] ne "NA" and $a[2] ne "NA") {
        my $min = $a[-3];
        $min = $a[-4] if ($a[-4] < $a[-3]);
        print STDOUT "36\t$c36a:$c36b\t$a[2]\t$min\n";
      }
    }
    close(DFP);
  }
}

# Parse 101 base pairs reads
for (my $i = 0; $i < scalar(@cells101) - 1; $i++) {
  my $c101a = $cells101[$i];
  for (my $j = $i + 1; $j < scalar(@cells101); $j++) {
    my $c101b = $cells101[$j];

    my $file = "dfp/$c101a"."vs$c101b/diffprofiles.dat";
    open(DFP, " < $file");
    while(<DFP>) {
      chomp;
      my @a = split;
      if ($a[0] ne "NA" and $a[1] ne "NA" and $a[2] ne "NA") {
        my $min = $a[-3];
        $min = $a[-4] if ($a[-4] < $a[-3]);
        print STDOUT "101\t$c101a:$c101b\t$a[2]\t$min\n";
      }
    }
    close(DFP);
  }
}
