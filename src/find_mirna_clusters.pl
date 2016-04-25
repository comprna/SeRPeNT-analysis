my @cells = ("a549", "gm12878", "helas3", "hepg2", "imr90", "k562", "mcf7", "nhek", "sknsh");

foreach $cell (@cells) {
  my $file = "dat/".$cell."/annotation.bed";
  my %clusters = ();

  open(FIL, " < $file");
  while(<FIL>) {
    chomp;
    my ($chr, $sbp, $ebp, $bio, $sco, $str, $sta, $ncl) = split "\t";
    next if ($sta eq "NOVEL");
    $clusters{$ncl}{$bio} = 0 if (!exists($clusters{$ncl}{$bio}));
    $clusters{$ncl}{$bio}++;
  }
  close(FIL);

  foreach $ncl (keys %clusters) {
    my %biotypes = %{ $clusters{$ncl} };
    my $majority_number = 0;
    my $majority_label = "";
    foreach $bio (keys %biotypes) {
      if ($clusters{$ncl}{$bio} > $majority_number) {
        $majority_number = $clusters{$ncl}{$bio};
        $majority_label = $bio;
      }
    }
    
    if ($majority_label eq "miRNA") {
      print "$cell\t$ncl";
      foreach $bio (keys %biotypes) {
        print "\t$bio:$clusters{$ncl}{$bio}" if ($clusters{$ncl}{$bio} > 0);
      }
      print "\n";
    }
  } 
}
