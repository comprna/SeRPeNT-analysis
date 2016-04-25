my %ids = ();
my %tpms = ();

open(MEAN, " < $ARGV[0]");
while(<MEAN>) {
  chomp;
  my ($cell, $tid, $enstid, $tpm) = split;
  my ($line, $rep) = split /\_/, $cell;
  $ids{$enstid} = $tid;
  $tpms{$enstid}{$line} = 0 if (!exists($tpms{$enstid}{$line}));
  $tpms{$enstid}{$line} += $tpm;
}
close(MEAN);

my @lines = ("a549", "gm12878", "helas3", "hepg2", "imr90", "k562", "mcf7", "nhek", "sknsh");
foreach $line (@lines) {
  foreach $enstid (keys %ids) {
    print "$line\t$ids{$enstid}\t$enstid\t", $tpms{$enstid}{$line} / 2, "\n";
  }
}
