# #################################################################################
# benchmark_novel_profiles.pl
#
# Calculates profiles that belong to the extended annotation by calculating entropy
# of classification across cell lines. All the profiles that overlap with genomic
# blacklisted regions are discarded
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# #################################################################################

use strict;

# Usage:
#   perl benchmark_novel_profiles.pl cutoff_score black_list_file
# Example:
#   perl benchmark_novel_profiles.pl 0.2 dat/hg19_blacklist_mappability.bed > dat/serpent_novel_profiles.bed

# Variable definition
my %mkdefs = ();  # var_id <-> var_value hashtable
my %unk = ();     # cluster_id <-> profile_array hashtable
my @cells = ("a549", "gm12878", "helas3", "hepg2", "imr90", "k562", "mcf7", "nhek", "sknsh");

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

# Read command line arguments
my ($cutoff_s, $black_list_f) = @ARGV;

# Read file and store information on unknown profiles
foreach my $cell (@cells) {
  my $input_f = "dat/$cell/annotation.bed";
  open(IN, " < $input_f");
  while(<IN>) {
    chomp;
    my ($chr, $sbp, $ebp, $bio, $scr, $str, $sta, $ncl) = split;
    $unk{$ncl}{$cell} = 0 if (!exists($unk{$ncl}{$cell}));
    $unk{$ncl}{$cell}++ if ($bio eq "unknown");
  }
}

# Filter NOVEL / LABELED profiles and store unlabeled profiles
my $result = `mkdir -p tmp`;
open(NOVEL, " > tmp/novel.unsorted.bed");
foreach my $cell (@cells) {
  my $input_f = "dat/$cell/annotation.bed";
  open(IN, " < $input_f");
  while(<IN>) {
    chomp;
    my ($chr, $sbp, $ebp, $bio, $scr, $str, $sta, $ncl) = split;
    my $id = $chr."\t".$sbp."\t".$ebp."\t".$bio."#".$cell."\t".$scr."\t".$str;
    print NOVEL "$id\n" if (($sta eq "NOVEL") and ($bio ne "unknown"));
    print NOVEL "$id\n" if (($sta eq "NOVEL") and ($bio eq "unknown") and ($unk{$ncl}{$cell} > 2));
  }
}

# Sort profiles
$result = `cat tmp/novel.unsorted.bed | sort -k1,1 -k2,2n > tmp/novel.sorted.bed`;

# Merge profiles
$result = `$bedtoolshome/bin/mergeBed -s -nms -scores mean -i tmp/novel.sorted.bed > tmp/novel.bed`;
my $report_novel = `wc -l tmp/novel.bed`;
chomp $report_novel;

# Intersect with blacklisted regions
$result = `$bedtoolshome/bin/intersectBed -s -v -a tmp/novel.bed -b $black_list_f > tmp/filtered.bed`;
my $report_white = `wc -l tmp/filtered.bed`;
chomp $report_white;

# Report NOVEL profiles
open(NOVEL, " < tmp/filtered.bed");
while(<NOVEL>) {
  chomp;
  my ($chr, $sbp, $ebp, $cls, $scr, $str) = split;

  my $ncells = 0;
  my @hits = split /;/, $cls;
  my %lines = ();
  my %types = ();

  for (my $i = 0; $i < scalar(@hits); $i++) {
    my ($ptype, $pline) = split /#/, $hits[$i];
    if (!exists($lines{$pline})) {
      $ncells++;
      $lines{$pline} = 1;
      if (!exists($types{$ptype})) {
        $types{$ptype} = 1;
      }
      else {
        $types{$ptype}++;
      }
    }
  }

  my $entropy = 0;
  my $majnumber = -1;
  my $majlabel = "";

  if ($ncells > 1) {
    foreach my $ptype (keys %types) {
      if ($majnumber < $types{$ptype}) {
        $majlabel = $ptype;
        $majnumber = $types{$ptype};
      }
      $entropy += ($types{$ptype} / $ncells) * log(($types{$ptype} / $ncells));
    }
    $entropy = ($entropy * (-1)) / log($ncells);
  }
  else {
    foreach my $ptype (keys %types) {
      $majlabel = $ptype;
    }
    $entropy = 0;
  }

  if ($entropy <= $cutoff_s) {
    print "$chr\t$sbp\t$ebp\t$majlabel\t$entropy\t$str\t$ncells\t", join(";", keys %lines), "\n";
  }
}
close(NOVEL);

# Delete tmp dir
$result = `rm -rf tmp`;

# Print stats
print STDERR "TOTAL NOVEL = $report_novel\n";
print STDERR "TOTAL WHITE = $report_white\n";
