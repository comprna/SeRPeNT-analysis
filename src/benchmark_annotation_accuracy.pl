# ########################################################
# benchmark_accuracy_annotation.pl
# 
# Performs 100 cross-fold validation accuracy benchmarking
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ########################################################

use strict;
use List::Util qw(shuffle);
use POSIX qw(ceil);

# Usage:
#   perl benchmark_accuracy_annotation.pl profile_file profile_distances_file profile_annotation_file nfolds
# e.g.
#   perl benchmark_accuracy_annotation dat/a549/profiles.dat dat/a549/crosscor.dat dat/a549/annotation.bed 10

# Variable definition
my %mkdefs = ();        # var_id <-> var_value hashtable
my %annotation = ();    # Profile_id<->BED_line hashtable
my %biotype = ();       # Biotype set
my %biotype_lists = (); # Biotype<->list_of_profiles hashtable
my @types = ();         # Unique biotype list
my $stats = ();         # Statistics

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
my $serpenthome = $mkdefs{"serpenthome"};

# Read command line arguments
my ($profile_f, $distance_f, $annotation_f, $overlap, $nfolds) = @ARGV;

# Set environment variables and prepare temporal folders
$ENV{LD_LIBRARY_PATH}="$serpenthome/lib/";
my $result = `mkdir -p /tmp/serpent`;

# Store all annotated profiles that are not predicted de-novo
# - Do not store profiles that are annotated as NOVEL
open(BED, " < $annotation_f");
while(<BED>) {
  chomp;
  my ($chr, $sbp, $ebp, $bio, $scr, $str, $status, $ncl) = split "\t";
  next if ($status eq "NOVEL");
  next if ($bio eq "rRNA" or $bio eq "scaRNA" or $bio eq "YRNA" or $bio eq "7SL" or $bio eq "7SK" or $bio eq "unknown");

  my $key = $chr.":".$sbp."-".$ebp.":".$str;
  my $val = $chr."\t".$sbp."\t".$ebp."\t".$bio."\t0\t".$str;
  $annotation{$key} = $val;
  $biotype{$bio} = "T";
  if (!exists($biotype_lists{$bio})) {
    $biotype_lists{$bio}{"COUNT"} = 0;
    $biotype_lists{$bio}{"ELEMENTS"} = ();
  }
  $biotype_lists{$bio}{"ELEMENTS"}[$biotype_lists{$bio}{"COUNT"}] = $key;
  $biotype_lists{$bio}{"COUNT"}++;
}
close(BED);
@types = keys %biotype;

# Store profiles that belong to non-de-novo-predicted profiles
open(TMP, " > /tmp/serpent/profiles.dat");
open(PRF, " < $profile_f");
while(<PRF>) {
  chomp;
  my ($id, @vals) = split "\t";
  if (exists($annotation{$id})) { print TMP "$_\n"; }
}
close(PRF);
close(TMP);

# Store profile distances that belong to non-de-novo-predicted profiles
open(TMP, " > /tmp/serpent/crosscor.dat");
open(XCR, " < $distance_f");
while(<XCR>) {
  chomp;
  my ($id1, $id2, $dst) = split "\t";
  if (exists($annotation{$id1}) and exists($annotation{$id2})) { print TMP "$id1\t$id2\t$dst\n"; }
}
close(XCR);
close(TMP);

# nfold-cross-validation
# - Remove 10% of annotated features from the annotation. 10% of each type of feature.
# - Run serpent on profiles with remaining 90% of the annotation
# - Compute contingency tables (TP, FP, TN & FN) for each type of feature
# - Write results
for (my $i = 0; $i < $nfolds; $i++) {
  my @new_annotation = ();
  my %removed_annotation = ();

  # Remove 10% of the annotation
  # Create removed annotation file
  foreach my $key (keys %biotype_lists) {
    my @tmp_a;
    foreach my $listid (@{ $biotype_lists{$key}{"ELEMENTS"} }) {
      push(@tmp_a, $listid);
    }
    my @tmp_b = shuffle @tmp_a;
    my $toremove = ceil($biotype_lists{$key}{"COUNT"} / 10);
    for (my $j = 0; $j < $toremove; $j++) {
      my $elem = shift @tmp_b;
      $removed_annotation{$elem} = "TRUE";
    }
    push(@new_annotation, @tmp_b);
  }

  open(TMP, " > /tmp/serpent/partial_annotation.bed");
  for (my $j = 0; $j < scalar(@new_annotation); $j++) { print TMP $annotation{$new_annotation[$j]}, "\n"; }
  close(TMP);

  # Execute serpent
  $result = `$serpenthome/bin/serpent annotate -a /tmp/serpent/partial_annotation.bed -o $overlap -x /tmp/serpent/crosscor.dat /tmp/serpent/profiles.dat /tmp/serpent/`;# 2>/dev/null`;

  # Collect stats
  my %results = ();
  for (my $j = 0; $j < scalar(@types); $j++) {
    my $bt = $types[$i]; 
    $results{$bt}{"TP"} = 0;
    $results{$bt}{"FP"} = 0;
    $results{$bt}{"TN"} = 0;
    $results{$bt}{"FN"} = 0;
  }
  my $unknowns = 0;
  my $totals = 0;
  my %failures = ();

  open(BED, " < /tmp/serpent/annotation.bed");
  while(<BED>) {
    chomp;
    my ($chr, $sbp, $ebp, $bio, $scr, $str, $cnb) = split "\t";
    my $id = $chr.":".$sbp."-".$ebp.":".$str;
    if (exists($removed_annotation{$id})) {
      my $line = $annotation{$id};
      my ($f1, $f2, $f3, $condition, $f4, $f5) = split "\t", $line;
      my $prediction = $bio;
      for (my $j = 0; $j < scalar(@types); $j++) {
        my $bt = $types[$j];
        $results{$bt}{"TP"}++ if (($condition eq $bt) and ($prediction eq $bt));
        $results{$bt}{"TN"}++ if (($condition ne $bt) and ($prediction ne $bt) and ($prediction ne "unknown"));
        $results{$bt}{"FP"}++ if (($condition ne $bt) and ($prediction eq $bt) and ($prediction ne "unknown"));
        $results{$bt}{"FN"}++ if (($condition eq $bt) and ($prediction ne $bt) and ($prediction ne "unknown"));

#        if (($condition ne $prediction) and ($prediction ne "unknown")){print STDERR "$f1:$f2-$f3:$f5\t$condition\t$id\t$prediction\n";}

        $failures{$condition}{$prediction} = 0 if (!exists($failures{$condition}{$prediction}));
        $failures{$condition}{$prediction}++;
      }
      $totals++;
      $unknowns++ if ($prediction eq "unknown");
    }
  }
  close(BED);

#  print STDERR "FOLD\n";
#  foreach $cdn (keys %failures) {
#    my %preds = %{ $failures{$cdn} };
#    foreach $prd (keys %preds) {
#      print STDERR "CONDITION : $cdn & PREDICTION : $prd = ", $failures{$cdn}{$prd}, "\n";
#    }
#  }

  for (my $j = 0; $j < scalar(@types); $j++) {
    my $bt = $types[$j];

    my ($tp, $tn, $fp, $fn) = (0, 0, 0, 0);
    $tp = $results{$bt}{"TP"} if (exists($results{$bt}{"TP"}));
    $tn = $results{$bt}{"TN"} if (exists($results{$bt}{"TN"}));
    $fp = $results{$bt}{"FP"} if (exists($results{$bt}{"FP"}));
    $fn = $results{$bt}{"FN"} if (exists($results{$bt}{"FN"}));

    my ($recall, $ppv, $acc, $f1, $mcc, $fpr) = (0, 0, 0, 0, 0, 0);
    $recall = $tp / ($tp + $fn) if (($tp + $fn) > 0);
    $ppv = $tp / ($tp + $fp) if (($tp + $fp) > 0);
    $acc = ($tp + $tn) / ($tp + $fn + $fp + $tn) if (($tp + $fn + $fp + $tn) > 0);
    $f1 = (2 * $tp) / (2 * $tp + $fp + $fn) if ((2 * $tp + $fp + $fn) > 0);
    $mcc = ($tp * $tn - $fp * $fn) / sqrt(($tp + $fp) * ($tp + $fn) * ($tn + $fp) * ($tn + $fn)) if (sqrt(($tp + $fp) * ($tp + $fn) * ($tn + $fp) * ($tn + $fn)) > 0);
    $fpr = $fp / ($fp + $tn) if (($fp + $tn) > 0);

    print STDOUT "$bt\tPPV\t$ppv\n";
    print STDOUT "$bt\tRECALL\t$recall\n";
    print STDOUT "$bt\tACCURACY\t$acc\n";
    print STDOUT "$bt\tFALLOUT\t$fpr\n";
    print STDOUT "$bt\tF1\t$f1\n";
    print STDOUT "$bt\tMCC\t$mcc\n";
  }

  $unknowns = $unknowns / $totals;
  print STDOUT "unknown\tPROPORTION\t$unknowns\n";
}
