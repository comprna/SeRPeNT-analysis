# ################################################################################
# retrieve_predicted_sequences.pl
#
# Retrieve extended sequences of novel profiles predicted by SeRPeNT
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ################################################################################

use strict;

# Usage:
#   perl retrieve_predicted_sequences.pl extended_annotation output_file extension
# e.g.
#   perl retrieve_predicted_sequences.pl dat/serpent_annotation_novel.bed dat/serpent_annotation_novel.fa 10

# Variable definition
my %mkdefs = ();   # var_id <-> var_value hashtable

# Read mks/makefile.defs
open(MKDEFS, " < mks/mkdefs.makefile");
while(<MKDEFS>) {
  chomp;
  next if (m/^$/);
  next if (m/#/);
  next if (!m/=/);

  my $line = $_;
  $line =~ s/\s+//g;
  my ($id, $vl) = split /=/, $line;
  $mkdefs{$id} = $vl;
}
close(MKDEFS);

# Set definitions in variables
my $fastafrombed = $mkdefs{"bedtoolshome"}."/bin/fastaFromBed";
my $hg19 = "dwn/".$mkdefs{"hg19"};

# Read command line arguments
my ($annotation_f, $output_f, $extension) = @ARGV;

# Parse annotation file and find sequences for
# - NOVEL
# - NOT unknown
# profiles
my $result = `mkdir -p tmpf`;
my $o_f = "tmpf/cluster.bed";

open(OUT, " > $o_f");
open(ANF, " < $annotation_f");
while(<ANF>) {
  chomp;
  my ($chr, $sbp, $ebp, $bio, $scr, $str, $ncl, $cls) = split;

  $sbp -= $extension;
  $ebp += $extension;

  print OUT "$chr\t$sbp\t$ebp\t$bio\t$scr\t$str\n";
}
close(ANF);
close(OUT);
$result = `$fastafrombed -s -fi $hg19 -bed $o_f -fo $output_f`;
$result = `rm -rf tmpf`;
