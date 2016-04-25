# ###############################################################
# transform_json_annotation.pl
#
# Transforms JSON annotation to color nodes with predicted labels 
#
# amadis.pages@upf.edu
# amadis.pages@crg.eu
# ###############################################################

# Usage:
#   perl transform_json_annotation.pl json_file annotation_file > json_file
# e.g.
#   perl transform_json_annotation.pl dat/a549/clusters.json dat/a549/annotation.bed > dat/a549/clusters.json

# Variable definition 
my %annotation = ();  # Profile id <-> BED-line hashtable
my %status = ();      # Profile id <-> Profile status hashtable
my %clusters = ();    # 
my %colours = ();     # Biotype <-> colour hashtable
my $json = "";        # JSON contents in a single line

# Fill colours table
$colours{"snoRNA"} = "red";
$colours{"miRNA"} = "blue";
$colours{"snRNA"} = "green";
$colours{"tRNA"} = "yellow";

# Read command line arguments
my ($json_f, $annotation_f) = @ARGV;

# Read annotation
open(BED, " < $annotation_f");
while(<BED>) {
  chomp;
  my ($chr, $sbp, $ebp, $bio, $scr, $str, $stt, $cls) = split;
  $annotation{"C".$cls."C"}{$bio} = 0 if (!exists($annotation{"C".$cls."C"}{$bio}));
  $annotation{"C".$cls."C"}{$bio}++;
}
close(BED);

# Calculate majority class in cluster
foreach my $ncl (keys %annotation) {
  my $label = "";
  my $majority = -1;
  my %bios = %{ $annotation{$ncl} };
  foreach my $bio (keys %bios) {
    if ($annotation{$ncl}{$bio} > $majority) {
      $label = $bio;
      $majority = $annotation{$ncl}{$bio};
    }
  }
  $annotation{$ncl} = $label;
  print STDERR "$ncl\t$annotation{$ncl}\n";
}

# Read JSON contents and store them in a single file
open(JSON, " < $json_f");
while(<JSON>) {
  chomp;
  next if (m/undefined symbol/);
  $json = $json.$_;
}
close(JSON);

# For each leaf in JSON file convert name into cluster colour level
foreach my $key (keys %annotation) {
  my ($bio, $col) = ($annotation{$key}, "black");
  $col = $colours{$bio} if (exists($colours{$bio}));
  $json =~ s/$key/$col/;
}
$json =~ s/display_label/level/g;
$json =~ s/NoName/white/g;
$json =~ s/\+//g;

# Print new json
print STDOUT $json;
