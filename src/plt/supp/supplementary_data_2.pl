# #################################################################################
# supplementary_data_2.pl
#
# Extended annotation in GTF format
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# #################################################################################

use strict;

# Usage:
#   perl supplementary_data_2.pl dat/serpent_annotation_extended.gtf > fig/supp/supplementary_data_2.gtf 

# Variable definition
my ($mirna_c, $snorna_c, $trna_c, $snrna_c, $curna_c) = (1, 1, 1, 1, 1); # Counters

# Parse command line
my ($ext_f) = $ARGV[0];

# Parse extended annotation
open(ANT, " < $ext_f");
while(<ANT>) {
  chomp;
  my ($chr, $sbp, $ebp, $bio, $score, $strand, @trash) = split;

  my $g_name;
  $g_name = "srpnt_miRNA_".$mirna_c++ if ($bio eq "miRNA");
  $g_name = "srpnt_snoRNA_".$snorna_c++ if ($bio eq "snoRNA");
  $g_name = "srpnt_snRNA_".$snrna_c++ if ($bio eq "snRNA");
  $g_name = "srpnt_tRNA_".$trna_c++ if ($bio eq "tRNA");
  $g_name = "srpnt_cuRNA_".$curna_c++ if ($bio eq "unknown");

  $bio = "cuRNA" if ($bio eq "unknown");

  print STDOUT "$chr\tSeRPeNT\tgene\t$sbp\t$ebp\t\.\t$strand\t\.\tgene_id \"$g_name\"; gene_type \"$bio\"; gene_name \"$g_name\"; transcript_id \"$g_name\"; transcript_type \"$bio\"; transcript_name \"$g_name\";\n";
  print STDOUT "$chr\tSeRPeNT\ttranscript\t$sbp\t$ebp\t\.\t$strand\t\.\tgene_id \"$g_name\"; gene_type \"$bio\"; gene_name \"$g_name\"; transcript_id \"$g_name\"; transcript_type \"$bio\"; transcript_name \"$g_name\";\n";
  print STDOUT "$chr\tSeRPeNT\texon\t$sbp\t$ebp\t\.\t$strand\t\.\tgene_id \"$g_name\"; gene_type \"$bio\"; gene_name \"$g_name\";  transcript_id \"$g_name\"; transcript_type \"$bio\"; transcript_name \"$g_name\";\n";
}
close(ANT);
