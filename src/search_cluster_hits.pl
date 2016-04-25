# #################################################################################
# search_cluster_hits.pl
#
# Generate a covariance model file and searches for hits in BLAST DB using infernal
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# #################################################################################

use strict;

# Usage:
#   perl search_cluster_hits.pl folder
# e.g.
#   perl search_cluster_hits.pl a549

# Variable definition
my %mkdefs = ();   # var_id <-> var_value hashtable
my %totals = ();   # Cluster_number <-> number_of_profiles
my %partials = (); # Cluster_number <-> number_of_unknown_profiles
my %seqs = ();     # Cluster_number <-> sequences_BED

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
my $vienna = $mkdefs{"viennabin"};
my $infernal = $mkdefs{"infernalbin"};
my $blastdb = "dwn/".$mkdefs{"blastnt"};

# Read command line arguments
my ($folder) = $ARGV[0];

# For each cluster from folder in cvm
my $result = `mkdir -p tmpm`;
opendir(DIR, "cvm");
opendir(DIR, "cvm");
while (my $file = readdir(DIR)) {
  next if (($file !~ m/\.fa$/) and ($file !~ m/^$folder/));
  $file =~ m/([0-9]+)$/;
  my $ali_f = "cvm/".$file."/cluster_".$1.".ali";
  my $sto_f = "cvm/".$file."/cluster_".$1.".sto";
  my $cm_f = "cvm/".$file."/cluster_".$1.".cm";
  my $hits_f = "cvm/".$file."/cluster_".$1.".hits";
  my $fhits_f = "cvm/".$file."/cluster_".$1.".fhits";

  # Convert ali file to stockholm file
  open(STO, " > $sto_f");
  print STO "# STOCKHOLM 1.0\n\n";
  close(STO);
  $result = `cat $ali_f >> $sto_f`;
  
  # Find consensus secondary structure
  my $result = `$vienna -r -d2 --noLP --noPS $sto_f > tmpm/cluster.rnafold`;
  my $sstructure;
  open(RNA, " < tmpm/cluster.rnafold");
  while(<RNA>) {
    chomp;
    $_ =~ /([\.\(\)]+)/;
    next if ($1 eq "");
    $sstructure = $1;
  }
  close(RNA);

  # Print SS_cons to STOCKHOLM file
  open(STO, " >> $sto_f");
  print STO "#=GC SS_cons $sstructure\n";
  print STO "//";
  close(STO);

  # Build CM model
  $result = `$infernal/cmbuild $cm_f $sto_f`;

  # Calibrate CM model
  $result = `$infernal/cmcalibrate $cm_f`;

  # Search in BLAST database
  $result = `$infernal/cmsearch --tblout $hits_f -E 0.01 $cm_f $blastdb`;

  # Filter hits
  open(FHITS, " > $fhits_f");
  open(HITS, " < $hits_f");
  while(<HITS>) {
    chomp;
    next if (!m/^>/);

    # Find header in database
    $_ =~ s/^>//g;
    $_ =~ s/\|$//g;
    my $header = `cat $blastdb | grep -m 1 \"$_\"`;
    chomp $header;

    # Find score
    my $line  = <HITS>;
    $line = <HITS> while($line !~ m/Score/);

    # Parse score
    $line =~ /Score = (.+?), E = (.+?), P = (.+?),/;
    my ($score, $evalue, $pvalue) = ($1, $2, $3);

    # Parse description
    my @headers = split /\cA/, $header;
    foreach my $hdr (@headers) {
      next if ($hdr =~ m/rRNA/);
      next if ($hdr =~ m/ribosomal/);
      next if ($hdr =~ m/DNA/);
      my @fields = split /\|/, $hdr;
      my $desc = pop(@fields);
      $desc =~ s/^ //g; $desc =~ s/\"//g; $desc =~ s/\'//g;
      my $id = join("|", @fields);
      $id =~ s/^>//g;
      print FHITS "$evalue\t$score\t$pvalue\t$id\t$desc\n";
    }
  }
  close(HITS);
  close(FHITS);
}
$result = `rm -rf tmpm`;
