#################################################################
# figure_3b.pl
#
# Differentially processed profiles between cellular compartments
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ###############################################################

use strict;
use List::Util qw(max);

# Usage:
#   perl figure_3b.pl annotation_file fold_change
# Example
#   perl figure_3b.pl dat/serpent_annotation_extended.bed 2.5

# Constants
my @comps = ("chromatin", "cytosol", "nucleolus", "nucleoplasm");
my @names = ("Chromatin", "Cytosol", "Nucleolus", "Nucleoplasm");
my @diffs = ("chvscy", "chvsno", "chvsnp", "cyvsno", "cyvsnp", "novsnp");
my @cmps_a = ("Chromatin", "Chromatin", "Chromatin", "Cytosol", "Cytosol", "Nucleolus");
my @cmps_b = ("Cytosol", "Nucleolus", "Nucleoplasm", "Nucleolus", "Nucleoplasm", "Nucleoplasm");

# Declare and define variables
my %annotations = ();  # compartment<->profile_id<->biotype

# Read command line arguments
my $fc = $ARGV[0];

# Open annotation files and store annotations
for (my $i = 0; $i < scalar(@comps); $i++) {
  my $folder = $comps[$i];
  my $name = $names[$i];
  my $file = "dat/".$folder."/annotation.bed";
  open(BED, " < $file");
  while(<BED>) {
    chomp;
    my ($chr, $sbp, $ebp, $bio, $scr, $str, $stt, $ncl) = split "\t";
    next if ($stt ne "KNOWN");
    my $id = $chr.":".$sbp."-".$ebp.":".$str;
    $annotations{$name}{$id} = $bio;
  }
  close(BED);
}

# Parse diffproc files
for (my $i = 0; $i < scalar(@diffs); $i++) {
  my $diff = $diffs[$i];
  my $c_a = $cmps_a[$i];
  my $c_b = $cmps_b[$i];
  my $i_f = "dfp/".$diff."/diffprofiles.dat";
  my %countings = ();
  my %differentially = ();

  # Count number of common profiles per biotype
  open(DFP, " < $i_f");
  while(<DFP>) {
    chomp;
    my ($id_a, $id_b, $pval, $foldchange, $fc_a, $fc_b, $n_a, $n_b) = split;

    next if ($id_a eq "NA" or $id_b eq "NA");
    next if (!exists($annotations{$c_a}{$id_a}));
    next if (!exists($annotations{$c_b}{$id_b}));
    next if ($annotations{$c_a}{$id_a} ne $annotations{$c_b}{$id_b});
    my $bio = $annotations{$c_a}{$id_a};

    $countings{$bio} = 0 if (!exists($countings{$bio}));
    $countings{$bio}++;

    next if ($n_a < 1 or $n_b < 1);
    next if ($pval eq "NO");
    next if (($fc_a < $fc) or ($fc_b < $fc));

    $differentially{$bio} = 0 if (!exists($differentially{$bio}));
    $differentially{$bio}++;
  }
  close(DFP);

  # Print results
  foreach my $bio (keys %differentially) {
    print STDOUT "$c_a\t$c_b\t$bio\t$differentially{$bio}\t$countings{$bio}\t", sprintf("%.2f", ($differentially{$bio} / $countings{$bio}) * 100), "\n";
    print STDOUT "$c_b\t$c_a\t$bio\t$differentially{$bio}\t$countings{$bio}\t", sprintf("%.2f", ($differentially{$bio} / $countings{$bio}) * 100), "\n";
  }
}
