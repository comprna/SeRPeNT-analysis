open(GTF, " < $ARGV[0]");
while(<GTF>) {
  chomp;
  next if (m/^#/ or m/^$/);

  my ($chr, $source, $feature, $sbp, $ebp, $score, $strand, $phase, $info)  = split "\t";

  next if ($feature ne "gene");
  next if ($chr !~ m/^chr/ and $chr !~ m/^[0-9]/ and $chr !~ m/^X/ and $chr !~ m/^Y/ and $chr !~ m/^MT/);

  $info =~ /gene_type "(.+?)"/ if ($info =~ m/gene_type/);
  my $biotype = $1;

  $info =~ /gene_name "(.+?)"/;
  my $name = $1;
  print "$chr\t$sbp\t$ebp\t$biotype\t$name\t$strand\n";
}
close(GTF);
