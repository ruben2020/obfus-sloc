use strict;

my $lin='';
my $cnt=0;
my $cnt2=0;
my $remain=0;
open(FIL,"prog.c");
while (<FIL>)
{
  chomp;
  $lin = $_;
  $lin =~ s/ //g;
  $lin =~ s/\t//g;
  $cnt += length($lin);
  $lin =~ s/([\;\{\}]+) //;
  $lin =~ s/([\;\{\}]+)\t//;
  $lin =~ s/([\;\{\}]+)$//;
  $cnt2 += length($lin);
}
close(FIL);
$remain = 2047 - $cnt;
print "$cnt, $remain\n";
$remain = 2047 - $cnt2;
print "$cnt2, $remain\n";

