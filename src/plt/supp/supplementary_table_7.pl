# #######################################################
# supplementary_table_7.pl
#
# Class switching between compartments
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# #######################################################

use strict;

# Usage:
#   perl supplementary_table_7.pl
# Example
#   perl supplementary_table_7.pl > fig/supp/supplementary_table_7.tab

# Declare and define variables
my @folders = ("chromatin", "cytosol", "nucleolus", "nucleoplasm");
my @names = ("Chromatin", "Cytosol", "Nucleolus", "Nucleoplasm");
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
my $bedtoolshome = $mkdefs{"bedtoolshome"};

# Parse all the annotation files
my $result = `mkdir -p tmp`;
open(TMP, " > tmp/mixed.bed");
for (my $i = 0; $i < scalar(@folders); $i++) {
  my $folder = $folders[$i];
  my $name = $names[$i];
  my $file = "dat/".$folder."/annotation.bed";

  my %mirnas = ();
  my %trnas = ();
  my %snornas = ();
  my %profiles = ();
  my %data = ();

  open(CELL, " < $file");
  while (<CELL>) {
    chomp;
    my ($chr, $sbp, $ebp, $bio, $scr, $str, $stt, $ncl) = split;

    $data{$ncl}{"IDX"} = 0 if (!exists($data{$ncl}));
    $data{$ncl}{"DAT"}[$data{$ncl}{"IDX"}] = $_;
    $data{$ncl}{"IDX"}++;

    $profiles{$ncl} = 0 if (!exists($profiles{$ncl}));
    $profiles{$ncl}++;

    $mirnas{$ncl} = 0 if (!exists($mirnas{$ncl}));
    $mirnas{$ncl}++ if (($bio eq "miRNA") and ($stt eq "KNOWN"));

    $trnas{$ncl} = 0 if (!exists($trnas{$ncl}));
    $trnas{$ncl}++ if (($bio eq "tRNA") and ($stt eq "KNOWN"));

    $snornas{$ncl} = 0 if (!exists($snornas{$ncl}));
    $snornas{$ncl}++ if (($bio eq "snoRNA") and ($stt eq "KNOWN"));
  }
  close(CELL);

  foreach my $mirna (keys %mirnas) {
    next if ($profiles{$mirna} < 2);
    
    if ((($trnas{$mirna} > 0) and ($mirnas{$mirna} > $trnas{$mirna})) or
        (($snornas{$mirna} > 0) and ($mirnas{$mirna} > $snornas{$mirna}))) {
      my @lines = @{ $data{$mirna}{"DAT"} };
      foreach my $line (@lines) {
        my ($chr, $sbp, $ebp, $bio, $scr, $str, $stt, $ncl) = split "\t", $line;
       print TMP "$chr\t$sbp\t$ebp\t$name\t$mirna\t$str\n"; # if ($stt eq "KNOWN");
      }
    }
  }
}
close(TMP);

# Intersect
$result = `${bedtoolshome}/bin/intersectBed -s -wao -a tmp/mixed.bed -b dat/gencodev19_annotation_nonfiltered.bed > tmp/mixedandmerged.bed`;
my $cc = -1;
my $cl = "";
my $cs = "";
my $ce = "";

open(MAM, " < tmp/mixedandmerged.bed");
while(<MAM>) {
  chomp;
  my @a = split;
  my $id = $a[0].":".$a[1]."-".$a[2].":".$a[5];

  if ($cc != $a[4]) {
    if ($cc >= 0) {
      print "$cs\t$cl\t$cc\t$ce\n";
    }
    $cc = $a[4];
    $ce = $a[3];
    if ($a[9] eq "miRNA") {
      $cs = "";
      $cl = $a[10];
    }
    elsif ($a[9] eq "\.") {
      $cs = "";
      $cl = $id;
    }
    else {
      $cs = $a[10];
      $cl = "";
    }
  }

  else {
    if ($a[9] eq "miRNA") {
      $cl = $cl.",".$a[10] if ($cl ne "");
      $cl = $a[10] if ($cl eq "");
    }
    elsif ($a[9] eq "\.") {
      $cl = $cl.",".$id if ($cl ne "");
      $cl = $id if ($cl eq "");
    }
    else {
      $cs = $cs.",".$a[10] if ($cs ne "");
      $cs = $a[10] if ($cs eq "");
    }
  }
}
close(MAM);
print "$cs\t$cl\t$cc\t$ce\n";
#$result = `rm -rf tmp`;
