# ############################################
# supplementary_table_5.pl
#
# Summary of ENCODE cell compartments profiles
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ############################################

use strict;

# Usage:
#   perl supplementary_table_5.pl [lines|compartments]
# Example
#   perl supplementary_table_5.pl compartments > fig/supp/supplementary_table_5.tab

# Declare and define variables
my @folders;
my @names;
my %nclusters = ();    # Folder<->Number_clusters hashtable
my %nsingletons = ();  # Folder<->Number_singletons hahstable
my %profiles = ();     # Folder<->Number_profiles hashtable
my %clusters = ();     # Folder<->Cluster_number<->Number_profiles hashtable
my %knowns = ();       # Folder<->Biotype<->Number_known_profiles hashtable
my %predicteds = ();   # Folder<->Biotype<->Number_predicted_profiles hashtable
my %biotypes = ();     # Biotype<->mock hashtable

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

  $profiles{$folder} = 0;

  open(CELL, " < $file");
  while (<CELL>) {
    chomp;
    my ($chr, $sbp, $ebp, $bio, $scr, $str, $stt, $ncl) = split;

    $bio = "unknown" if ($stt eq "NOVEL");

    $profiles{$folder}++;

    $biotypes{$bio} = "T";
    
    $clusters{$folder}{$ncl} = 0 if (!exists($clusters{$folder}{$ncl}));
    $clusters{$folder}{$ncl}++;

    $knowns{$folder}{$bio} = 0 if (!exists($knowns{$folder}{$bio}));
    $knowns{$folder}{$bio}++ if ($stt eq "KNOWN");

    $predicteds{$folder}{$bio} = 0 if (!exists($predicteds{$folder}{$bio}));
    $predicteds{$folder}{$bio}++ if ($stt eq "NOVEL");
  }
  close(CELL);
}

# Calculate number of clusters and singletons
foreach my $folder(keys %clusters) {
  my %clusts = %{ $clusters{$folder} };
  $nclusters{$folder} = 0;
  $nsingletons{$folder} = 0;

  foreach my $cluster (keys %clusts) {
    $nclusters{$folder}++ if ($clusters{$folder}{$cluster} > 1);
    $nsingletons{$folder}++ if ($clusters{$folder}{$cluster} <= 1);
  }
}

# Print header
print STDOUT "*\t*";
foreach my $name (@names) { print STDOUT "\t$name"; }
print STDOUT "\n";

# Print values for known
foreach my $bio (keys %biotypes) {
  #next if ($bio eq "unknown");
  print "Known\t$bio";
  foreach my $folder (@folders) {
    my $rounded = sprintf("%.2f", $knowns{$folder}{$bio} / $profiles{$folder} * 100);
    print "\t$knowns{$folder}{$bio} ($rounded%)";
  }
  print "\n";
}

# Print values for unknowns
print STDOUT "Unknown\t*";
foreach my $folder (@folders) {
  my $rounded = sprintf("%.2f", $predicteds{$folder}{"unknown"} / $profiles{$folder} * 100);
  print "\t", $predicteds{$folder}{"unknown"}, " ($rounded%)";
}
print STDOUT "\n";

# Print number of profiles
print STDOUT "# profiles\t*";
foreach my $folder (@folders) { print STDOUT "\t$profiles{$folder}"; }
print STDOUT "\n";

# Print number of clusters
print STDOUT "# clusters\t*";
foreach my $folder (@folders) { print STDOUT "\t$nclusters{$folder}"; }
print STDOUT "\n";

# Print number of singletons
print STDOUT "# singletons\t*";
foreach my $folder (@folders) { print STDOUT "\t$nsingletons{$folder}"; }
print STDOUT "\n";
