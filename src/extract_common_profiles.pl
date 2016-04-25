# #################################################################################
# extract_common_profiles.pl
#
# Extract common profiles from diffproc benchmarking cell lines 
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# #################################################################################

use strict;

# Usage:
#   perl extract_common_profiles.pl 

# Variable definition
my %mkdefs = ();        # var_id <-> var_value hashtable
my @cells = ("a549", "gm12878", "helas3", "hepg2", "ag04450", "bj", "mcf7", "h1hesc", "sknsh");

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

# Filter NOVEL / LABELED profiles
my $result = `mkdir -p tmp`;
open(BED, " > tmp/unsorted.bed");
foreach my $cell (@cells) {
  my $input_f = "bnm/$cell/profiles.dat";
  open(IN, " < $input_f");
  while(<IN>) {
    chomp;
    my ($id, @vals) = split;
    my ($chr, $cor, $str) = split /:/, $id;
    my ($sbp, $ebp) = split /\-/, $cor;
    print BED "$chr\t$sbp\t$ebp\t$cell\t0\t$str\n";
  }
}
close(BED);

# Sort profiles
$result = `cat tmp/unsorted.bed | sort -k1,1 -k2,2n > tmp/sorted.bed`;

# Merge profiles
$result = `$bedtoolshome/bin/mergeBed -s -nms -i tmp/sorted.bed > tmp/merged.bed`;

# Report merged profiles
open(BED, " < tmp/merged.bed");
while(<BED>) {
  chomp;
  my ($chr, $sbp, $ebp, $cls, $str) = split;

  my $ncells = 0;
  my @hits = split /;/, $cls;
  my %lines = ();

  for (my $i = 0; $i < scalar(@hits); $i++) {
    my $pline = $hits[$i];
    if (!exists($lines{$pline})) {
      $ncells++;
      $lines{$pline} = 1;
    }
  }

  print STDOUT "$chr\t$sbp\t$ebp\t$chr:$sbp-$ebp:$str\t$ncells\t$str\n" if ($ncells == 9);
}
close(BED);

# Delete tmp folder
$result = `rm -rf tmp`;
