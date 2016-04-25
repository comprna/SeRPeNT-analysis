# #################################################################################
# calculate_lincrna_expression.pl
#
# Calculate lincRNA expression table
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# #################################################################################

use strict;

# Usage:
#   perl calculate_lincrna_expression.pl 

# Variable definition
my @cells = ("a549", "gm12878", "helas3", "hepg2", "imr90", "k562", "mcf7", "nhek", "sknsh");
my @ensts = ("RP5-857K21.4", "GAS5", "RP11-458N5.1", "RP11-444A22.1", "RP11-141B14.1", "AC093381.2", "LINC00578", "RP11-328K4.1",
             "RP11-549K20.1", "RP11-1E3.1", "CTD-2374C24.1", "PVT1", "NEAT1", "MALAT1", "RP11-820L6.1", "FRMD6-AS2", "AC013394.2",
             "RP11-304L19.5", "SNORA76", "MIR663A", "RP5-1125A11.1", "LINC00657", "RP11-40F8.2");
my %params = map { $_ => 1 } @ensts;

# Read mks/makefile.defs
for my $cell (@cells) {
  open(EXP, " < dat/$cell/rep_1.dat");
  while(<EXP>) {
    chomp;
    next if (m/target_id/);
    my ($id, $length, $eff_length, $est_counts, $tpm) = split;
    my @a = split /\|/, $id;
    print $cell, "_1\t$a[-2]\t$a[0]\t$tpm\n" if (exists($params{$a[-2]}));
  }
  close(EXP);
  open(EXP, " < dat/$cell/rep_2.dat");
  while(<EXP>) {
    chomp;
    next if (m/target_id/);
    my ($id, $length, $eff_length, $est_counts, $tpm) = split;
    my @a = split /\|/, $id;
    print $cell, "_2\t$a[-2]\t$a[0]\t$tpm\n" if (exists($params{$a[-2]}));
  }
  close(EXP);
}
