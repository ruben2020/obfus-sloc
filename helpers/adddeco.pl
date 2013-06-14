use strict;

my $totaladditions = 5;

my @additions=
(
"goto a1\nblurb \"              \"\na1:",
"goto a2\nblurb \"  DEDICATED TO            \"\na2:",
"goto a3\nblurb \"  DENNIS RITCHIE (1941-2011)  \"\na3:",
"goto a4\nblurb \"  CO-INVENTOR OF C AND UNIX   \"\na4:",
"goto a5\nblurb \"                            \"\na5:"
);

my @skipchars=
(
78+36,
96+36,
102+36,
104+36,
108+36
);

open(FIL, "asm.txt");
open(FILO,">asm2.txt");

my $num = 0;
my $lin = '';
my $skipindex = 0;
while(<FIL>)
{
  chomp;
  $lin = $_;
  $lin =~ s/  / /g;
  $lin =~ s/\t\t/ /g;
  $lin =~ s/^([\t ]*)//g;
  $lin =~ s/([\t ]*)$//g;
  $lin =~ s/([\t ]*):/:/g;
  if ($lin =~ /([A-Za-z0-9_]+):/)
  {
    # Nothing to do
  }
  elsif ($lin =~ /([A-Za-z0-9_]+)([\t ]*)(.*)/)
  {
     $num++;
     if (($num*2 == $skipchars[$skipindex]+2)&&($skipindex<$totaladditions))
     {
        print FILO "$additions[$skipindex]\n";
        $skipindex++;
     }
  }
  print FILO "$lin\n";
}


close(FIL);
close(FILO);


