# ##################################################################################
# figure_2b.pl
#
# Hierarchical clustering of the clusters of profiles for a cell line or compartment
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ##################################################################################

use strict;

# Usage:
#   perl figure_2b.pl folder
# Example
#   perl figure_2b.pl a549

# Define and declare variables
my %clusters = ();  # Cluster_number <-> @Profile_ids hashtable
my %clusteri = ();  # Cluster_number <-> Array_index hashtable
my %dists = ();     # Profile_id <-> Profile_id <-> Distance hashtable
my @ncls = ();      # Cluster_number sorted array

# Parse command line
my $folder = $ARGV[0];

# Initialize variables
my $bed_f = "dat/".$folder."/annotation.bed";
my $xcr_f = "dat/".$folder."/crosscor.dat";

# Parse the annotation file
open(BED, " < $bed_f");
while(<BED>) {
  chomp;
  my ($chr, $sbp, $ebp, $nam, $sco, $str, $stt, $ncl) = split;
  my $id = $chr.":".$sbp."-".$ebp.":".$str;

  $clusteri{$ncl} = 0 if (!exists($clusteri{$ncl}));
  $clusters{$ncl}[$clusteri{$ncl}] = $id;
  $clusteri{$ncl}++;
}
close(BED);

# Remove singletons
foreach my $ncl (keys %clusters) {
  delete $clusters{$ncl} if ($clusteri{$ncl} < 2);
  delete $clusteri{$ncl} if ($clusteri{$ncl} < 2);
}
@ncls = sort {$a <=> $b} (keys %clusters);

# Parse the distances file
open(XCR, " < $xcr_f");
while(<XCR>) {
  chomp;
  my ($id1, $id2, $xcr) = split;
  $dists{$id1}{$id2} = $xcr;
  $dists{$id2}{$id1} = $xcr;
}
close(XCR);

# Ouput distances between clusters
print STDOUT "C$ncls[0]C";
for (my $i = 1; $i < scalar(@ncls); $i++) {
  print "\tC$ncls[$i]C";
}
print "\n";
for (my $i = 0; $i < scalar(@ncls); $i++) {
  print "C$ncls[$i]C";
  for (my $j = 0; $j < scalar(@ncls); $j++) {
    my $cl1 = $ncls[$i];
    my $cl2 = $ncls[$j];
    my $mean = 0;
    my $nprf = 0;
    my @prf1 = @{ $clusters{$cl1} };
    my @prf2 = @{ $clusters{$cl2} };
    foreach my $p1 (@prf1) {
      foreach my $p2 (@prf2) {
        $mean += $dists{$p1}{$p2};
        $nprf++;
      }
    }
    $mean = $mean / $nprf;
    $mean = 0 if ($i == $j);
    print STDOUT "\t$mean";
  }
  print "\n";
}
