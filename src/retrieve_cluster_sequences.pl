# ################################################################
# retrieve_cluster_sequences.pl
#
# Retrieve profile sequences from cluster made of unknown profiles
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ################################################################

use strict;

# Usage:
#   perl retrieve_cluster_sequences.pl folder_id cluster_annotation_file extension number_sequences_threshold sequence_similarity_threshold
# e.g.
#   perl retrieve_cluster_sequences.pl a549 dat/a549/annotation.bed 10 3 0.8

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
my $fastafrombed = $mkdefs{"bedtoolshome"}."/bin/fastaFromBed";
my $ggsearch = $mkdefs{"ggsearchbin"};
my $hg19 = "dwn/".$mkdefs{"hg19"};

# Read command line arguments
my ($folder, $annotation_f, $extension, $nseqt, $similart) = @ARGV;

# Parse annotation file and fill totals and partials
open(ANF, " < $annotation_f");
while(<ANF>) {
  chomp;
  my ($chr, $sbp, $ebp, $bio, $scr, $str, $stt, $ncl) = split;

  $totals{$ncl} = 0 if (!exists($totals{$ncl}));
  $partials{$ncl} = 0 if (!exists($partials{$ncl}));
  $totals{$ncl}++;
  $partials{$ncl}++ if ($bio eq "unknown");
}
close(ANF);

# Parse annotation file and find sequences
#  - All elements in the cluster are unknown
#  - Cluster has more than one element
open(ANF, " < $annotation_f");
while(<ANF>) {
  chomp;
  my ($chr, $sbp, $ebp, $bio, $scr, $str, $stt, $ncl) = split;
  $sbp -= $extension;
  $ebp += $extension;
  my $id = $chr.":".$sbp."-".$ebp.":".$str;
  my $seq = $chr."\t".$sbp."\t".$ebp."\t".$id."\t".$scr."\t".$str;

  if (($totals{$ncl} == $partials{$ncl}) and ($totals{$ncl} >= $nseqt)) {
    $seqs{$ncl}{"IDX"} = 0 if (!exists($seqs{$ncl}));
    $seqs{$ncl}{"VAL"} = () if (!exists($seqs{$ncl}));
    $seqs{$ncl}{"VAL"}[$seqs{$ncl}{"IDX"}] = $seq;
    $seqs{$ncl}{"IDX"}++;
  }
}
close(ANF);

# Print sequences
my $result = `mkdir -p tmp`;

foreach my $key (keys %seqs) {
  my $o_f = "tmp/cluster.bed";
  my $f_f = "tmp/cluster.fa";
  open(OUT, " > $o_f");
  my @vals = @{ $seqs{$key}{"VAL"} };
  print OUT join("\n", @vals);
  close(OUT);
  $result = `$fastafrombed -s -fi $hg19 -bed $o_f -fo $f_f`;

  my @ids;
  my @seqs;
  open(CLS, " < tmp/cluster.fa");
  while(<CLS>) {
    chomp;
    push(@ids, $_) if (m/^>/);
    push(@seqs, $_) if (!m/^>/);
  }
  close(CLS);

  my $sims = 0;
  my $ttl = 0;
  for (my $i = 0; $i < (scalar(@vals) - 1); $i++) {
    open(CLUA, " > tmp/cluster_a.fa");
    print CLUA $ids[$i], "\n";
    print CLUA $seqs[$i], "\n";
    close(CLUA); 
    for (my $j = $i + 1; $j < scalar(@vals); $j++) {
      open(CLUB, " > tmp/cluster_b.fa");
      print CLUB $ids[$j], "\n";
      print CLUB $seqs[$j], "\n";
      close(CLUB);
      $result = `$ggsearch -d 1 tmp/cluster_a.fa tmp/cluster_b.fa > tmp/result.dat`;
      open(RST, " < tmp/result.dat");
      while(<RST>) {
        chomp;
        next if (!m/similar/);
        $_ =~ /([0-9]+\.[0-9]+)\% similar/;
        $sims += ($1 + 0);
      }
      close(RST); 
      $ttl++;
    }
  }

  # Next if similarity is too high
  next if (($sims/$ttl) > $similart);

  # Copy BED file
  my $t_f = "cvm/".$folder."_".$key;
  my $t_bed = $t_f."/cluster_".$key.".bed";
  my $t_fasta = $t_f."/cluster_".$key.".fa";
print STDERR "$t_f\t$t_bed\t$t_fasta\n";
  $result = `mkdir -p $t_f`;
  $result = `cp tmp/cluster.bed $t_bed`;
  
  # Copy FASTA file
  open(FIN, " < tmp/cluster.fa");
  open(FOUT, " > $t_fasta");
  while(<FIN>) {
    chomp;
    if ($_ =~ m/^>/) {
      print FOUT "$_\n";
    }
    else {
      my $newstring = uc($_);
      my @achar = split '', $newstring;
      for (my $i = 0; $i < 10; $i++) {
        $achar[$i] = lc($achar[$i]);
        $achar[($i + 1) * -1] = lc ($achar[($i + 1) * -1]);
      }
      print FOUT join('', @achar), "\n";
    }
  }
  close(FIN);
  close(FOUT);   
}

$result = `rm -rf tmp`;
