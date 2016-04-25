# ###################################################################
# intersect_diffproc_expression.pl
#
# Find overlapping of expression in differentially processed profiles
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ###################################################################

use strict;

# Usage:
#   perl intersect_diffproc_expression.pl diffproc_file a_in_b_file b_in_a_file out_bed_file
# e.g.
#   perl intersect_diffproc_expression.pl dfp/wtvsdcr/diffprofiles.dat dfp/wtvsdcr/dicer_in_wild.bed dfp/wtvsdcr/wild_in_dicer.bed dfp/wtvsdcr/diffprofiles.bed

# Variable definition
my %a_in_b = ();
my %b_in_a = ();

# Read command line arguments
my ($diffproc_f, $a_in_b_f, $b_in_a_f, $out_bed_f) = @ARGV;

# Parse a_in_b file
open(BED, " < $a_in_b_f");
while(<BED>) {
  chomp;
  my ($chr, $sbp, $ebp, $nam, $sco, $str) = split;
  my $id = $chr.":".$sbp."-".$ebp.":".$str;
  $a_in_b{$id} = $sco;
}
close(BED);

# Parse b_in_a file
open(BED, " < $b_in_a_f");
while(<BED>) {
  chomp;
  my ($chr, $sbp, $ebp, $nam, $sco, $str) = split;
  my $id = $chr.":".$sbp."-".$ebp.":".$str;
  $b_in_a{$id} = $sco;
}
close(BED);

# Parse diffprofiles file and print expressed and differentially processed files
open(BED, " > $out_bed_f");
open(DIFF, " < $diffproc_f");
while(<DIFF>) {
  chomp;
  my ($id_a, $bio_a, $id_b, $bio_b, $fc_a, $fc_b) = split;
  if (($id_a eq "NA") and (exists($a_in_b{$id_b}))) {
    my ($chr, $cor, $str) = split /:/, $id_b;
    my ($sbp, $ebp) = split /\-/, $cor;
    print STDOUT "$id_a\t$id_b\t$fc_a\t$fc_b\n" if ($a_in_b{$id_b} > 10);
    print BED "$chr\t$sbp\t$ebp\t$id_b\t0\t$str\n" if ($a_in_b{$id_b} > 10);;
  }
  elsif (($id_b eq "NA") and (exists($b_in_a{$id_a}))) {
    my ($chr, $cor, $str) = split /:/, $id_a;
    my ($sbp, $ebp) = split /\-/, $cor;
    print STDOUT "$id_a\t$id_b\t$fc_a\t$fc_b\n" if ($b_in_a{$id_a} > 10);
    print BED "$chr\t$sbp\t$ebp\t$id_a\t0\t$str\n" if ($b_in_a{$id_a} > 10);;
  }
  elsif (($id_a ne "NA") and ($id_b ne "NA")) {
    my ($chr, $cor, $str) = split /:/, $id_a;
    my ($sbp, $ebp) = split /\-/, $cor;
    print STDOUT "$id_a\t$id_b\t$fc_a\t$fc_b\n";
    print BED "$chr\t$sbp\t$ebp\t$id_a\t0\t$str\n";
  }
}
close(DIFF);
close(BED);
