# #################################################################################
# benchmark_diffproc_profiles.pl
#
# Benchmark differential profiles with Pundhir and Gorodkin
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# #################################################################################

use strict;

# Usage:
#   perl benchmark_diffproc_profiles.pl 

# Variable definition
my %mkdefs = ();        # var_id <-> var_value hashtable
my @cells = ("gm12878", "sknsh", "mcf7", "helas3", "a549", "h1hesc", "hepg2", "ag04450", "bj");

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
my ($common_f, $pundhir_f, $foldchange) = @ARGV;

# Pundhir
my $result = `mkdir -p tmp`;
for (my $i = 0; $i < 8; $i++) {
  for (my $j = $i + 1; $j < 9; $j++) {
    my ($cel1, $idx1) = ($cells[$i], $i * 2);
    my ($cel2, $idx2) = ($cells[$j], $j * 2);
    my ($count_pun, $count_ser, $count_com) = (0, 0, 0);
    my $file_a = "dfp/".$cel1."vs".$cel2."/diffprofiles.dat";
    my $file_b = "dfp/".$cel2."vs".$cel1."/diffprofiles.dat";
    my $file = "";

    # Checks if file exists
    $file = $file_a if (-r $file_a);
    $file = $file_b if (-r $file_b);

    # Read Pundhir
    open(OUTPUN, " > tmp/pundhir.bed");
    open(PUN, " < $pundhir_f");
    while(<PUN>) {
      chomp;
      my @a = split;
      my @b = split /,/, $a[-1];
      if ($b[$idx1] ne $b[$idx2]) {
        $count_pun++;
        pop(@a);
        print OUTPUN join("\t", @a), "\n";
      }
    }
    close(PUN);
    close(OUTPUN);

    # Serpent file exists
    if ($file ne "") {

      # Read serpent
      open(OUTSER, " > tmp/serpent.bed");
      open(SER, " < $file");
      while (<SER>) {
        chomp;
        my @a = split;
        my ($cor1, $cor2, $pval, $fch) = ($a[0], $a[1], $a[2], $a[3]);
  
        if (($a[0] ne "NA") and ($a[1] ne "NA") and ($a[2] ne "NO") and ($a[4] >= $foldchange) and ($a[5] >= $foldchange) and ($a[-1] + $a[-2] > 0)) {
          my ($chr1, $coors1, $str1) = split /:/, $cor1;
          my ($chr2, $coors2, $str2) = split /:/, $cor2;
          my ($sbp, $ebp) = split /\-/, $coors1;
          my ($sbp2, $ebp2) = split /\-/, $coors2;
          $sbp = $sbp2 if ($sbp2 < $sbp);
          $ebp = $ebp2 if ($ebp2 > $ebp);
          print OUTSER "$chr1\t$sbp\t$ebp\t$chr1:$sbp-$ebp:$str1\t0\t$str1\n";
        }
      }
      close(SER);
      close(OUTSER);

      # Execute bedtools to find differentially processed profiles in SeRPeNT that are common in all 9 cell lines
      $result = `$bedtoolshome/bin/intersectBed -s -wa -a tmp/serpent.bed -b $common_f > tmp/all.bed`;
      open(SER, " < tmp/all.bed");
      my @serpentr = <SER>;
      close(SER);
      $count_ser = scalar(@serpentr);

      # Execute bedtools
      $result = `$bedtoolshome/bin/intersectBed -s -wa -a tmp/all.bed -b tmp/pundhir.bed > tmp/common.bed`;
      open(COM, " < tmp/common.bed");
      while(<COM>) {
        chomp;
        $count_com++;
      }
    }

    print STDOUT "$cel1\t$cel2\t", $count_pun - $count_com, "\t", $count_ser - $count_com, "\t$count_com\n";
  }
}
