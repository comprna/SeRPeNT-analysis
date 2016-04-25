# #################################################
# figure_3a.pl
#
# Clustering solutions for ENCODE cell compartments
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# #################################################

use List::Util qw(shuffle);
use strict;

# Usage:
#   perl figure_3a.pl threshold
# e.g.
#   perl figure_3a.pl 5 > tmp/inputR.tab

# Variable definition
my @folders = ("chromatin", "cytosol", "nucleolus", "nucleoplasm");
my @names = ("Chromatin", "Cytosol", "Nucleolus", "Nucleoplasm");

# Parse command line
my $threshold = $ARGV[0];

# Parse annotation files
for (my $i = 0; $i < scalar(@names); $i++) {
  my $folder = $folders[$i];
  my $name = $names[$i];
  my $annotation_f = "dat/".$folder."/annotation.bed";

  # Parse annotation file
  my %annotation = ();
  my %counts = ();
  my %partials = ();

  open(BED, " < $annotation_f");
  while(<BED>) {
    chomp;
    my ($chr, $sbp, $ebp, $bio, $scr, $str, $stt, $ncl) = split "\t";

    $counts{$ncl} = 0 if (!exists($counts{$ncl}));
    $counts{$ncl}++;

    if ($stt eq "KNOWN") {
      $partials{$ncl} = 0 if (!exists($counts{$ncl}));
      $partials{$ncl}++;
      $annotation{$ncl}{$bio} = 0 if (!exists($annotation{$ncl}{$bio}));
      $annotation{$ncl}{$bio}++;
    }
  }
  close(BED);

  # Remove singletons
  foreach my $cluster (keys %counts) {
    #my $cnt = $counts{$cluster};
    my $cnt = $partials{$cluster};
    delete $counts{$cluster} if ($cnt < $threshold);
    delete $annotation{$cluster} if ($cnt < $threshold);
    delete $partials{$cluster} if ($cnt < $threshold);
  }

  # Calculate and print entropies
  my $index = 1;
  foreach my $cluster (keys %annotation) {
    my %types = %{ $annotation{$cluster} };
    my $entropy = 0;
    my $total = $partials{$cluster};
    #my $total = $counts{$cluster};
    my $biomax = -1;
    my $label;

    foreach my $biotype (keys %types) {
      if ($biomax <= $types{$biotype}) {
        $biomax = $types{$biotype};
        $label = $biotype;
      }
      my $plabel = $types{$biotype} / $total;
      $entropy -= $plabel * (log($plabel) / log(2));
    }

    my $elems = $counts{$cluster};

    print STDOUT "$name\t$index\t$cluster\t", $entropy / (log($total) / log(2)), "\t$elems\t$label\t$total\n" if ($total > 1);
    print STDOUT "$name\t$index\t$cluster\t0\t$elems\t$label\t$total\n" if ($total < 2);

    $index++;
  }
}
