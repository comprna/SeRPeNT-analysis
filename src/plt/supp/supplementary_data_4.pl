# ################################################
# supplementary_data_3.pl
#
# List of unknown clusters in ENCODE cell lines
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ################################################

use strict;

# Usage:
#   perl supplementary_data_3.pl
# Example
#   perl supplementary_data_3.pl > fig/supp/supplementary_data_3.tab

# Declare and initialize variables
my %names = ("a549" => "A549",
             "gm12878" => "GM12878",
             "helas3" => "HeLa-S3",
             "hepg2" => "HepG2",
             "imr90" => "IMR90",
             "k562" => "K562",
             "mcf7" => "MCF-7",
             "nhek" => "NHEK",
             "sknsh" => "SK-N-SH");
my %mkdefs;

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
my $bedtools = $mkdefs{"bedtoolshome"}."/bin/intersectBed";

# Parse files from all folder lines
opendir(DIR, "cvm");
while (my $file = readdir(DIR)) {
  next if ($file =~ m/^\./);

  $file =~ m/^([a-z0-9]+)\_([0-9]+)$/;
  my $folder = $1;
  my $cluster = $2;
  my $name = $names{$folder};

  my $bed_f = "cvm/$file/cluster_".$cluster.".bed";
  my $fhits_f = "cvm/$file/cluster_".$cluster.".fhits";
  my $sto_f = "cvm/$file/cluster_".$cluster.".sto";
  my $ovp_f = "cvm/$file/cluster_".$cluster.".ovp";

  # Print CELL LINE
  print STDOUT "$name\t";

  # Print CLUSTER NUMBER
  print STDOUT "$cluster\t";

  # Print number of profiles
  open(BED, " < $bed_f");
  my @bed = <BED>;
  close(BED);
  print STDOUT scalar(@bed), "\t";

  # Print if consensus secondary structure exists
  open(SS, " < $sto_f");
  while(<SS>) {
    chomp;
    next if (!m/^#=GC/);
    print STDOUT "YES\t" if (m/\(/);
    print STDOUT "NO\t" if (!m/\(/);
  }
  close(SS);

  # Print if hits are present
  open(FHITS, " < $fhits_f");
  my @fhits = <FHITS>;
  close(FHITS);
  print STDOUT "YES\t" if (scalar(@fhits) > 0);
  print STDOUT "NO\t" if (scalar(@fhits) <= 0);

  # Print overlap with DICER-KD
  my $result = `$bedtools -s -wa -a $bed_f -b dfp/wtvsdcr/diffprofiles.bed | wc -l`;
  chomp $result;
  print STDOUT "ALL\t" if ($result == scalar(@bed));
  print STDOUT "YES\t" if (($result > 0) and ($result < scalar(@bed)));
  print STDOUT "NO\t" if ($result == 0);

  # Print overlap with DICER-BS
  $result = `$bedtools -s -wa -a $bed_f -b dat/rybak-wolf_dicer_binding-sites.bed | wc -l`;
  chomp $result;
  print STDOUT "ALL\t" if ($result == scalar(@bed));
  print STDOUT "YES\t" if (($result > 0) and ($result < scalar(@bed)));
  print STDOUT "NO\t" if ($result == 0);

  # Print overlap with DROSHA-KD
  $result = `$bedtools -s -wa -a $bed_f -b dfp/wtvsdrsh/diffprofiles.bed | wc -l`;
  chomp $result;
  print STDOUT "ALL\t" if ($result == scalar(@bed));
  print STDOUT "YES\t" if (($result > 0) and ($result < scalar(@bed)));
  print STDOUT "NO\t" if ($result == 0);

  # Print overlap with DGCR8-BS
  $result = `$bedtools -s -wa -a $bed_f -b dat/macias_dgcr8_binding-sites.bed | wc -l`;
  chomp $result;
  print STDOUT "ALL\t" if ($result == scalar(@bed));
  print STDOUT "YES\t" if (($result > 0) and ($result < scalar(@bed)));
  print STDOUT "NO\t" if ($result == 0);

  # Print overlaps with genomic features
  $result = `$bedtools -s -wao -a $bed_f -b dat/gencodev19_annotation_all.bed > $ovp_f`;
  my %overlaps = ();
  open(OVP, " < $ovp_f");
  while(<OVP>) {
    chomp;
    my @a = split "\t";
    $overlaps{$a[9]} = "T" if ($a[9] ne ".");
    $overlaps{"intergenic"} = "T" if ($a[9] eq ".");
  }
  close(OVP);
  my @features = keys %overlaps;
  print join("; ", @features);

  # End
  print STDOUT "\n";
}
close(DIR);
