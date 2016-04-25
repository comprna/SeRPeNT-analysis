# ################################################
# supplementary_table_3.pl
#
# Accuracy of the prediction of predicted profiles
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ################################################

use strict;

# Usage:
#   perl supplementary_table_3.pl [lines|compartments]
# Example
#   perl supplementary_table_3.pl > fig/supp/supplementary_table_3.tab

# Variable definitions
my @folders;
my @names;
my %mcc = ();      # Cell-line <-> Biotype <-> Mean_MCC hashtable
my %ppv = ();      # Cell-line <-> Biotype <-> Mean_PPV hashtable
my %rec = ();      # Cell-line <-> Biotype <-> Mean_RECALL hashtable
my %unk = ();      # Cell-line <-> Biotype <-> Mean_unknown_PROPORTION hashtable
my %biotypes = (); # Biotype<->mock hahstable

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

# Parse files from all folder lines
foreach my $folder (@folders) {
  my $file = "dat/".$folder."/accuracy.stats";
  my $counts = 0;

  open(CELL, " < $file");
  while(<CELL>) {
    chomp;
    my ($biotype, $metric, $value) = split;

    if ($metric eq "PROPORTION") {
      $unk{$folder} = 0 if (!exists($unk{$folder}));
      $unk{$folder} += $value;
    }

    next if (($metric ne "PPV") and ($metric ne "MCC") and ($metric ne "RECALL"));

    $biotypes{$biotype} = "T";

    $mcc{$folder}{$biotype} = 0 if (!exists($mcc{$folder}{$biotype}));
    $ppv{$folder}{$biotype} = 0 if (!exists($ppv{$folder}{$biotype}));
    $rec{$folder}{$biotype} = 0 if (!exists($rec{$folder}{$biotype}));

    $mcc{$folder}{$biotype} += $value if ($metric eq "MCC");
    $ppv{$folder}{$biotype} += $value if ($metric eq "PPV");
    $rec{$folder}{$biotype} += $value if ($metric eq "RECALL");

    $counts++;
  }
  close(CELL);

  # Adjust total number of counts
  $counts = $counts / (scalar(keys %biotypes) * 3);

  # Calculate means
  foreach my $biotype (keys %biotypes) { 
    $mcc{$folder}{$biotype} = $mcc{$folder}{$biotype} / $counts;
    $ppv{$folder}{$biotype} = $ppv{$folder}{$biotype} / $counts;
    $rec{$folder}{$biotype} = $rec{$folder}{$biotype} / $counts;
  }
  $unk{$folder} = $unk{$folder} / $counts;
}

# Print results in tabular format
my @biotype_l = keys %biotypes;
print STDOUT "*";
for (my $i = 0; $i < scalar(@biotype_l); $i++) {
  print STDOUT "\t$biotype_l[$i]\t$biotype_l[$i]\t$biotype_l[$i]";
}
print STDOUT "\tUnknown\n*";
for (my $i = 0; $i < scalar(@biotype_l); $i++) {
  print STDOUT "\tPrec.\tRecall\tMCC";
}
print STDOUT "\tRatio\n";
for (my $i = 0; $i < scalar(@folders); $i++) {
  my $folder = $folders[$i];
  my $name = $names[$i];
  print STDOUT $name;
  for (my $j = 0; $j < scalar(@biotype_l); $j++) {
    my $mcc_v = sprintf("%.2f", $mcc{$folder}{$biotype_l[$j]});
    my $ppv_v = sprintf("%.2f", $ppv{$folder}{$biotype_l[$j]});
    my $rec_v = sprintf("%.2f", $rec{$folder}{$biotype_l[$j]});
    print STDOUT "\t$ppv_v\t$rec_v\t$mcc_v";
  }
  my $unk_v = sprintf("%.1f \%", $unk{$folder} * 100);
  print STDOUT "\t$unk_v\n";
}
