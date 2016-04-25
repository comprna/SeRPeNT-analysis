# ################################################
# supplementary_data_1.pl
#
# Extended annotation
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ################################################

use strict;

# Usage:
#   perl supplementary_data_1.pl extended_bed annotation_1_bed annotation_2_bed hits_file threshold
# Example
#   perl supplementary_data_1.pl dat/serpent_annotation_novel.bed dat/friedlander_micrornas_annotation.bed dat/dashr_sncrna_annotation.bed dat/serpent_annotation_novel.hits 0.01 > fig/supp/supplementary_data_1.tab

# Variable definition
my %mkdefs = ();  # var_id <-> var_value hashtable
my %cross1 = ();  # profile_id <-> T/F hashtable
my %cross2 = ();  # profile_id <-> T/F hashtable
my %cellsn = ();  # profile_id <-> number_cell_lines hashtable
my %biotys = ();  # profile_id <-> biotype hashtable
my %famils = ();  # profile_id <-> rfam_id hashtable
my %pvalus = ();  # profile_id <-> rfam_p-value hashtable
my %hlinks = ();  # profile_id <-> rfam_link hashtable
my @profis = ();  # profile_ids

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
my ($extended_f, $annotation_1_f, $annotation_2_f, $hits_f, $pval_t) = @ARGV;

# Parse extended annotation
my $result = `mkdir -p tmp`;
open(EXT, " < $extended_f");
while(<EXT>) {
  chomp;
  my ($chr, $sbp, $ebp, $biotype, $score, $str, $ncells, $cells) = split;
  my $id = $chr.":".$sbp.":".$ebp.":".$str;

  $cross1{$id} = "NO";
  $cross2{$id} = "NO";
  $cellsn{$id} = $cells;
  $biotys{$id} = $biotype;
  $famils{$id} = "";
  $pvalus{$id} = 1;

  push(@profis, $id);
}
close(EXT);

# Parse hits
open(HITS, " < $hits_f");
while(<HITS>) {
  chomp;
  next if (($_ =~ m/^#/) or ($_ =~ m/^$/));

  my ($htrg, $hrid, $hpid, $hacc, $hmdl, $hmdf, $hmdt, $hsef, $hset, $hstr, $htru, $hpas, $hgc, $hbia, $hsco, $heva, $hinc, $hdes) = split ' ';
  my $hlink = my $hlink = "http://rfam.xfam.org/family/$hrid";
  $hpid =~ s/\(/:/g;
  $hpid =~ s/\)//g;
  my ($chr, $cor, $str) = split /:/, $hpid;
  my ($sbp, $ebp) = split /\-/, $cor;
  $sbp += 10; $ebp -= 10;
  my $id = $chr.":".$sbp.":".$ebp.":".$str;

  $famils{$id} = $htrg if (($heva < $pval_t) and ($heva < $pvalus{$id}) and ($htrg !~ m/rRNA/) and ($htrg !~ m/_SRP/));
  $hlinks{$id} = $hlink if (($heva < $pval_t) and ($heva < $pvalus{$id}) and ($htrg !~ m/rRNA/) and ($htrg !~ m/_SRP/));
  $pvalus{$id} = $heva if (($heva < $pval_t) and ($heva < $pvalus{$id}) and ($htrg !~ m/rRNA/) and ($htrg !~ m/_SRP/));
}

# Intersect with annotation 1
$result = `$bedtoolshome/bin/intersectBed -wa -a $extended_f -b $annotation_1_f > tmp/cross.bed`;
open(CRO, " < tmp/cross.bed");
while(<CRO>) {
  chomp;
  my ($chr, $sbp, $ebp, $biotype, $score, $str, $ncells) = split;
  my $id = $chr.":".$sbp.":".$ebp.":".$str;

  $cross1{$id} = "YES";
}
close(CRO);

# Intersect with annotation 2
$result = `$bedtoolshome/bin/intersectBed -wa -a $extended_f -b $annotation_2_f > tmp/cross.bed`;
open(CRO, " < tmp/cross.bed");
while(<CRO>) {
  chomp;
  my ($chr, $sbp, $ebp, $biotype, $score, $str, $ncells) = split;
  my $id = $chr.":".$sbp.":".$ebp.":".$str;

  $cross2{$id} = "YES";
}
close(CRO);

# Print results
foreach my $id (@profis) {
  my ($chr, $sbp, $ebp, $str) = split /:/, $id;
  my $link = "https://genome.ucsc.edu/cgi-bin/hgTracks?db=hg19&position=$chr%3A$sbp-$ebp";
  print "$chr:$sbp-$ebp:$str\t$biotys{$id}\t$link\t$cellsn{$id}\t$cross1{$id}\t$cross2{$id}\t$famils{$id}\t$hlinks{$id}\t$pvalus{$id}\n";
}
