my @mirnaseqs = ();
my %mirnacountsf = ();
my %mirnacountst = ();

my %normals = ();
my %tumours = ();

my @normals = ("SRR039611", "SRR039612", "SRR039613");
my @tumours = ("SRR039619", "SRR039621");

open(MIR, " < $ARGV[0]");
while(<MIR>) {
  chomp;
  push(@mirnaseqs, $_);
  my ($mirid, $mirseq) = split "\t", $_;
  $normals{$mirid} = 0;
  $tumours{$mirid} = 0;
}
close(MIR);

for my $nor (@normals) {
  foreach my $mir (@mirnaseqs) {
    my ($mirid, $mirseq) = split "\t", $mir;
    $mirnacountsf{$mirid} = 0;
    $mirnacountst{$mirid} = 0;
  }

  my $file = "bnm/normal/".$nor.".txt";
  open(SRR, " < $file");
  while(<SRR>) {
    chomp;
    my ($len, $count, $seq) = split;
    foreach my $mir (@mirnaseqs) {
      my ($mirid, $mirseq) = split "\t", $mir;
      my $half = length($mirseq) / 2;
      if ($mirseq =~ m/$seq/) {
        my $start = index($mirseq, $seq);
        $mirnacountsf{$mirid} += $count if ($start < $half);
        $mirnacountst{$mirid} += $count if (($start + length($seq)) > $half);
      }
    }
  }
  close(SRR);

  foreach my $mir (@mirnaseqs) {
    my ($mirid, $mirseq) = split "\t", $mir;
    $normals{$mirid} += $mirnacountsf{$mirid} / ($mirnacountst{$mirid} + 1);
  }
}

for my $tum (@tumours) {
  foreach my $mir (@mirnaseqs) {
    my ($mirid, $mirseq) = split "\t", $mir;
    $mirnacountsf{$mirid} = 0;
    $mirnacountst{$mirid} = 0;
  }

  my $file = "bnm/tumour/".$tum.".txt";
  open(SRR, " < $file");
  while(<SRR>) {
    chomp;
    my ($len, $count, $seq) = split;
    foreach my $mir (@mirnaseqs) {
      my ($mirid, $mirseq) = split "\t", $mir;
      my $half = length($mirseq) / 2;
      if ($mirseq =~ m/$seq/) {
        my $start = index($mirseq, $seq);
        $mirnacountsf{$mirid} += $count if ($start < $half);
        $mirnacountst{$mirid} += $count if (($start + length($seq)) > $half);
      }
    }
  }
  close(SRR);

  foreach my $mir (@mirnaseqs) {
    my ($mirid, $mirseq) = split "\t", $mir;
    $tumours{$mirid} += $mirnacountsf{$mirid} / ($mirnacountst{$mirid} + 1);
    #print "$tum\t$mirid\t", $mirnacountsf{$mirid} / ($mirnacountst{$mirid} + 1), "\n";
  }

  print "\n";
}

foreach my $mir (@mirnaseqs) {
  my ($mirid, $mirseq) = split "\t", $mir;
  my $norer = $normals{$mirid} / 3;
  my $tumer = $tumours{$mirid} / 2;
  print "$mirid\t$norer\t$tumer\t", (-1) * ($tumer/$norer), "\n" if ($tumer > $norer);
  print "$mirid\t$norer\t$tumer\t", ($norer/$tumer), "\n" if ($norer > $tumer);
}
