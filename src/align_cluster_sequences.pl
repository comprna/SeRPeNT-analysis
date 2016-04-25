# #################################################################################################
# align_cluster_sequences.pl
#
# Align profile sequences from cluster made of unknown profiles and find common secondary structure
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# #################################################################################################

use strict;

# Usage:
#   perl align_cluster_sequences.pl folder_id
# e.g.
#   perl align_cluster_sequences.pl a549

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
my $rnastruc = $mkdefs{"rnastructurebin"}."/multilign";

# Read command line arguments
my ($folder) = $ARGV[0];

# For each cluster from folder in cvm
my $result = `mkdir -p tmp`;
opendir(DIR, "cvm");
while (my $file = readdir(DIR)) {
  next if (($file !~ m/\.fa$/) and ($file !~ m/^$folder/));
  $file =~ m/([0-9]+)$/;
  my $fasta_f = "cvm/".$file."/cluster_".$1.".fa";
  my @seqsfiles = ();
  my @ctfiles = ();
  my $sindex = 1;
  open(FASTA, " < $fasta_f");
  while(<FASTA>) {
    chomp;
    if (m/^>/) {
      push (@seqsfiles, "tmp/seq_".$sindex.".fa");
      push (@ctfiles, "cvm/".$file."/seq_".$sindex.".ct");
      open(TMP, " > tmp/seq_".$sindex.".fa");
      print TMP "$_\n";
      close(TMP); 
    }
    else {
      open(TMP, " >> tmp/seq_".$sindex.".fa");
      my $line = uc($_);
      $line =~ s/T/U/g;
      print TMP "$line\n";
      close(TMP);
      $sindex++;
    }
  }
  close(FASTA);
  open(CFG, " > tmp/config.cfg");
  print CFG "InSeq = {";
  print CFG join(";", @seqsfiles);
  print CFG "}\n";
  print CFG "OutCT = {";
  print CFG join(";", @ctfiles);
  print CFG "}\n";
  print CFG "Alignment = cvm/", $file, "/cluster_".$1.".ali\n";
  close(CFG);
  $result = `$rnastruc tmp/config.cfg`;
}
$result = `rm -rf tmp`;
