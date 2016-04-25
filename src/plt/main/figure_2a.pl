# #######################################
# figure_2a.pl
#
# Summary of the known and novel profiles
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# #######################################

use strict;

# Usage:
#   perl figure_2a.pl [lines|compartments]
# Example
#   perl figure_2a.pl lines > tmp/inputR.tab

# Declare and define variables
my @folders;
my @names;

# Parse command line
my $analysis = $ARGV[0];

# Initialize variables
if ($analysis eq "lines") {
  @folders = ("a549", "gm12878", "helas3", "hepg2", "imr90", "k562", "mcf7", "nhek", "sknsh");
  @names = ("A549", "GM12878", "HeLa-S3", "HepG2", "IMR90", "K562", "MCF-7", "NHEK", "SK-N-SH");
}
elsif ($analysis eq "compartments") {
  @folders = ("chromatin", "cytosol", "nucleolus", "nucleoplasm");
  @names = ("Chromatin", "Cytosol", "Nucleolus", "Nucleoplasm");
}

# Parse all the annotation files
for (my $i = 0; $i < scalar(@folders); $i++) {
  my $folder = $folders[$i];
  my $name = $names[$i];
  my $file = "dat/".$folder."/annotation.bed";

  my $knowns = 0;
  my $novels = 0;

  open(CELL, " < $file");
  while (<CELL>) {
    chomp;
    my ($chr, $sbp, $ebp, $bio, $scr, $str, $stt, $ncl) = split;

    $knowns++ if ($stt eq "KNOWN");
    $novels++ if ($stt eq "NOVEL");
  }
  close(CELL);

  print STDOUT "$name\tKnown\t$knowns\n";
  print STDOUT "$name\tNovel\t$novels\n";
}
