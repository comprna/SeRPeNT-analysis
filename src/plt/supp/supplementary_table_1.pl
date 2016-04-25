# ############################################################
# supplementary_table_1.pl
#
# Classification performance for BlockClust, DARIO and SeRPeNT
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ############################################################

use strict;

# Usage:
#   perl supplementary_table_1.pl
# Example
#   perl supplementary_table_1.pl > fig/supp/supplementary_table_1.tab

# Declare and initialize variables
my %ppv = (); # bio_accumulated-PPV hashtable
my %tpr = 0;  # bio_accumulated-TPR hashtable
my $tot = 0;  # Number of predictions

# Parse stats file
open(STATS, " < dat/bnm/accuracy.stats");
while(<STATS>) {
  chomp;
  my($bio, $met, $val) = split;
  $ppv{$bio} = 0 if (!exists($ppv{$bio}));
  $tpr{$bio} = 0 if (!exists($tpr{$bio}));
  $ppv{$bio} += $val if ($met eq "PPV");
  $tpr{$bio} += $val if ($met eq "RECALL");
  $tot++ if ($met eq "PROPORTION");
}
close(STATS);

# Print table
print STDOUT "*\tmiRNA\tmiRNA\ttRNA\ttRNA\tsnoRNA C/D-box\tsnoRNA C/D-box\n";
print STDOUT "BlockClust\t0.88\t0.89\t0.95\t0.80\t0.74\t0.39\n";
print STDOUT "DARIO\t0.85\t0.81\t0.92\t0.88\t0.46\t0.52\n";
print STDOUT "SeRPeNT\t", sprintf("%.2f", $ppv{"miRNA"} / $tot), "\t", sprintf("%.2f", $tpr{"miRNA"} / $tot), "\t";
print STDOUT sprintf("%.2f", $ppv{"tRNA"} / $tot), "\t", sprintf("%.2f", $tpr{"tRNA"} / $tot), "\t";
print STDOUT sprintf("%.2f", $ppv{"snoRNA"} / $tot), "\t", sprintf("%.2f", $tpr{"snoRNA"} / $tot), "\n";
