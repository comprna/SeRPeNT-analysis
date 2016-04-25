# #################################################################################################
# generate_gencode_annotation.pl
#
# Filter Gencode annotation (GTF) files in order to extract miRNA, snRNA, snoRNA and tRNA
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# #################################################################################################

use strict;

# Usage:
#   perl generate_gencode_annotation.pl gtf_file_1 ... gtf_file_n
# e.g.
#   perl generate_gencode_annotation.pl gencode.v19.annotation.gtf gencode.v19.tRNAs.gtf

# Variable definition
my %mkdefs = (); # var_id <-> var_value hashtable

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
my @gtfs = @ARGV;

# Parse annotations
my $result = `mkdir -p tmp`;
open(OUT, " > tmp/annotation.bed");
foreach my $gtf_f (@gtfs) {
  open(GTF, " < $gtf_f");
  while(<GTF>) {
    chomp;
    next if (m/^#/ or m/^$/);

    my ($chr, $source, $feature, $sbp, $ebp, $score, $strand, $phase, $info)  = split "\t";

    next if ($feature ne "transcript" and $feature ne "tRNAscan");
    next if ($chr =~ m/^chrM/);

    $info =~ /transcript_biotype "(.+?)"/ if ($info =~ m/transcript_biotype/);
    $info =~ /transcript_type "(.+?)"/ if ($info =~ m/transcript_type/);
    my $biotype = $1;

    $info =~ /transcript_name "(.+?)"/;
    my $name = $1;
    print OUT "$chr\t$sbp\t$ebp\tmiRNA\t$name\t$strand\n" if ($biotype eq "miRNA");
    print OUT "$chr\t$sbp\t$ebp\tsnRNA\t$name\t$strand\n" if ($biotype eq "snRNA");
    print OUT "$chr\t$sbp\t$ebp\tsnoRNA\t$name\t$strand\n" if ($biotype eq "snoRNA");
    print OUT "$chr\t$sbp\t$ebp\ttRNA\t$name\t$strand\n" if ($biotype eq "tRNAscan");
  }
  close(GTF);
}
close(OUT);

# Sort and merge annotation
$result = `sort -k1,1 -k2,2n tmp/annotation.bed > tmp/sorted.bed`;
$result = `$bedtoolshome/bin/mergeBed -s -nms  -scores collapse -i tmp/sorted.bed | sort -k1,1 -k2,2n > tmp/merged.bed`;

# Read merged annotation and discard features that are multiannotated
open(INF, " < tmp/merged.bed");
while(<INF>) {
  chomp;
  my @a = split;
  next if ($a[3] =~ m/;/);
  print "$_\n";
}
close (INF);
$result = `rm -rf tmp`;
