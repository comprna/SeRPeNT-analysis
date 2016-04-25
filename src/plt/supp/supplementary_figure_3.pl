# ###########################################################################
# supplementary_figure_3.pl
#
# Benchmarking against (Li et al. 2010) on microRNA arm switching
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ###########################################################################

use strict;

# Usage:
#   perl supplementary_figure_3.pl diffproc_file li_et_al_file
# Example
#   perl supplementary_figure_3.pl dfp/normalvstumour/diffprofiles.dat dat/li_ratios_mirnas.bed > tmp/inputR.tab

# Variable definition
my %mkdefs = ();        # var_id <-> var_value hashtable

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
my $bedtoolshome = $mkdefs{"bedtoolshome"};            

# Parse command line
my ($diffproc_f, $ratios_f, $fold_change) = @ARGV;

# Parse diffproc file
my $result = `mkdir -p tmpf`;
open(OUT, " > tmpf/diffproc.bed");
open(DFP, " < $diffproc_f");
while(<DFP>) {
  chomp;
  my @a = split "\t";
  next if ($a[0] eq "NA" or $a[1] eq "NA");
  next if ($a[-1] < 1 or $a[-2] < 1);
  my ($chr1, $cor1, $str1) = split /:/, $a[0];
  my ($sbp1, $ebp1) = split /\-/, $cor1;
  my ($chr2, $cor2, $str2) = split /:/, $a[1];
  my ($sbp2, $ebp2) = split /\-/, $cor1;
  my $sbp = $sbp1;
  my $ebp = $ebp1;
  $sbp = $sbp2 if ($sbp2 < $sbp1);
  $ebp = $ebp2 if ($ebp2 > $ebp1);
  print OUT "$chr1\t$sbp\t$ebp\t$a[2]\t$a[-4]#$a[-3]\t$str1\n";
}
close(DFP);
close(OUT);

# Intersect
$result = `$bedtoolshome/bin/intersectBed -s -wao -a $ratios_f -b tmpf/diffproc.bed > tmpf/intersect.bed`;
open(BED, " < tmpf/intersect.bed");
open(OUT, " > tmpf/final.bed");
while(<BED>) {
  chomp;
  my @a = split;
  next if ($a[-1] == 0);
  my ($mirna, $dfpli, $dfpsr, $fcs) = ($a[3], $a[4], $a[9], $a[10]);
  my ($fc1, $fc2) = split "#", $fcs;
  my $fc = $fc1;
  $fc = $fc2 if ($fc2 > $fc1);
  $fc = log($fc) / log(10);
  my $dp = "Yes";
  $dp = "No" if ($dfpli == 0);
  my $dps = "Yes";
  print OUT "$mirna\t$dp\t$fc\n";
}
close(BED);
close(OUT);

# Report
$result = `sort -n -k3 tmpf/final.bed`;
print STDOUT $result;
$result = `rm -rf tmpf`;
