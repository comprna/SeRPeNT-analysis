my %ids = ();
my %tpms = ();

open(MEAN, " < $ARGV[0]");
while(<MEAN>) {
  chomp;
  my ($cell, $srnid, $rpm) = split;
  my ($line, $rep) = split /\_/, $cell;
  $ids{$srnid} = "T";
  $tpms{$srnid}{$line} = 0 if (!exists($tpms{$srnid}{$line}));
  $tpms{$srnid}{$line} += $rpm;
}
close(MEAN);

my @lines = ("a549", "gm12878", "helas3", "hepg2", "imr90", "k562", "mcf7", "nhek", "sknsh");
foreach $line (@lines) {
  foreach $srnid (keys %ids) {
    print "$line\t$srnid\t", $tpms{$srnid}{$line} / 2, "\n";
  }
}
