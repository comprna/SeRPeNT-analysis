# #################################################################################################
# calculate_differential_expression.pl
#
# Generates a matrix with expression data of the SeRPeNT extended annotation features in
# AGO-loaded and DICER-knockdown samples
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# #################################################################################################

use strict;

# Usage:
#   perl calculate_differential_expression.pl extended_annotation_file ago-loaded_r1_exp_file ago-loaded_r2_exp_file dicer-kd_r1_exp_file dicer-kd_r2_exp_file
# e.g.
#   perl calculate_differential_expression.pl dat/serpent_annotation_extended.bed dat/knockdown/SRR1176667.exp dat/knockdown/SRR1176668.exp dat/knockdown/SRR1657195.exp dat/knockdown/SRR1657196.exp

# Define vars
my %counts_al_r1 = (); # Feature_id <-> counts_ago-loaded_r1
my %counts_al_r2 = (); # Feature_id <-> counts_ago-loaded_r2
my %counts_kd_r1 = (); # feature_id <-> counts_dicer-kd_r1
my %counts_kd_r2 = (); # feature_id <-> counts_dicer-kd_r2

# Parse command line
my ($extended_a_f, $al_e_r1_f, $al_e_r2_f, $dk_e_r1_f, $dk_e_r2_f) = @ARGV;

# Parses SeRPeNT novel annotation file
open(SER, " < $extended_a_f");
while(<SER>) {
  chomp;
  my @a = split;
  my $id = join("#", @a);
  $counts_al_r1{$id} = 0;
  $counts_al_r2{$id} = 0;
  $counts_kd_r1{$id} = 0;
  $counts_kd_r2{$id} = 0;
}
close(SER);

# Parse AGO-loaded Replicate 1 expression file
open(EXP, " < $al_e_r1_f");
while(<EXP>) {
  chomp;
  my ($cnt, @a) = split;
  my $id = join("#", @a);
  $counts_al_r1{$id} = $cnt;
}
close(EXPR);

# Parse AGO-loaded Replicate 2 expression file
open(EXP, " < $al_e_r2_f");
while(<EXP>) {
  chomp;
  my ($cnt, @a) = split;
  my $id = join("#", @a);
  $counts_al_r2{$id} = $cnt;
}
close(EXPR);

# Parse DICER-knockdown Replicate 1 expression file
open(EXP, " < $dk_e_r1_f");
while(<EXP>) {
  chomp;
  my ($cnt, @a) = split;
  my $id = join("#", @a);
  $counts_kd_r1{$id} = $cnt;
}
close(EXPR);

# Parse DICER-knockdown Replicate 2 expression file
open(EXP, " < $dk_e_r2_f");
while(<EXP>) {
  chomp;
  my ($cnt, @a) = split;
  my $id = join("#", @a);
  $counts_kd_r2{$id} = $cnt;
}
close(EXPR);

# Print matrix
print STDOUT "control-1\tcontrol-2\tknockdown-1\tknockdown-2\n";
foreach my $id (keys %counts_al_r1) {
  print STDOUT "\"$id\"\t$counts_al_r1{$id}\t$counts_al_r2{$id}\t$counts_kd_r1{$id}\t$counts_kd_r2{$id}\n";
}
