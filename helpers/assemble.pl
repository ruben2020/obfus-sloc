use strict;

my $fn = "asm2.txt";
my $lin;
my %labels;
my %usedlabels;
my $num;
my $branchgotonum=0;
my $operand;
my $operandlength;
my $tempopcode;
my $chars='';
my $orilin;
my %opcodes =
(
  "nop"    => 0,
  "blurb"  => 0,
  "clearA" => 8,
  "clearM" => 14,
  "clearK" => 12,
  "incrA" => 6,
  "incrK" => 10,
  "setM" => 16,
  "readchar" => 0,
  "cmpIsLF" => 13,
  "cmpIsEOF" => 9,
  "cmp" => 1,
  "cmpIsQuote" => 5,
  "cmpIsSpace" => 1,
  "cmpIsTab" => 21,
  "cmpIsCR" => 22,
  "cmpLastIsCR" => 23,
  "cmpLastLastBackSlash" => 24,
  "cmpLastIsLF" => 29,
  "cmpLastBackSlash" => 30,
  "branch" => 0,
  "goto" => 0,
  "branchUp" => 28,
  "gotoUp" => 26,
  "branchDn" => 27,
  "gotoDn" => 25,
  "addMToA" => 4,
  "return" => 31,
  "cmpLast" => 19,
);

open(FIL,$fn);
$num = 0;
while(<FIL>)
{
  chomp;
  $lin = $_;
  $orilin = $_;
  $lin =~ s/  / /g;
  $lin =~ s/\t\t/ /g;
  $lin =~ s/^([\t ]*)//g;
  $lin =~ s/([\t ]*)$//g;
  $lin =~ s/([\t ]*):/:/g;
  if ($lin =~ /([A-Za-z0-9_]+):/)
  {
    if (defined $labels{$1}) {die("Label $lin already defined\n");}
    if (defined $opcodes{$1}) {die("Opcodes can't be used as labels\n");}
    $labels{$1} = $num+1;
    print "$lin\n";
  }
  elsif ($lin =~ /([A-Za-z0-9_]+)([\t ]*)(.*)/)
  {
     if (!(defined $opcodes{$1})) {die("Opcode $1 not defined\n");}
     $num++;
     print "[$num] $lin\n";
     if ($orilin =~ /blurb \"(.+)\"/) {$num += length($1)/2-1;}
     if ($1 eq 'goto') {$usedlabels{$3} = 1;}
     if ($1 eq 'branch') {$usedlabels{$3} = 1;}
  }
}
close(FIL);

my $val;
foreach $val(keys %usedlabels) {if (!(defined $labels{$val})) {die("Used label \"$val\" is not defined\n");}}
foreach $val(keys %labels) {if (!(defined $usedlabels{$val})) {die("Defined Label \"$val\" is not used\n");}}

open(FIL,$fn);
$num = 0;
while(<FIL>)
{
  chomp;
  $lin = $_;
  $orilin = $_;
  $lin =~ s/  / /g;
  $lin =~ s/\t\t/ /g;
  $lin =~ s/^([\t ]*)//g;
  $lin =~ s/([\t ]*)$//g;
  $lin =~ s/([\t ]*):/:/g;
  if ($lin =~ /([A-Za-z0-9_]+):/)
  {
    # Nothing to do
    if (defined $opcodes{$1}) {die("Opcodes can't be used as labels\n");}
  }
  elsif ($lin =~ /([A-Za-z0-9_]+)([\t ]*)(.*)/)
  {
     $num++;
     $tempopcode = $1;
     $operand = $3;
     if ($tempopcode eq 'blurb')
     {
       if ($orilin =~ /blurb \"(.+)\"/) {$operand = $1;}
       $operandlength = length($operand);
       if ($operandlength % 2 != 0) {die("Blurb $num \"$operand\" $operandlength should be in even number of chars\n");}
       $num += $operandlength/2-1;
       $chars .= $operand;
       #$chars .= "~".&randoperand();
     }
     elsif ($tempopcode eq 'nop')
     {
       $chars .= "#".&randoperand();
     }
     elsif ($tempopcode eq 'clearA')
     {
       $chars .= chr($opcodes{$tempopcode}+93).&randoperand();
     }
     elsif ($tempopcode eq 'clearM')
     {
       $chars .= chr($opcodes{$tempopcode}+93).&randoperand();
     }
     elsif ($tempopcode eq 'clearK')
     {
       $chars .= chr($opcodes{$tempopcode}+93).&randoperand();
     }
     elsif ($tempopcode eq 'incrA')
     {
       $chars .= chr($opcodes{$tempopcode}+93).&randoperand();
     }
     elsif ($tempopcode eq 'incrK')
     {
       $chars .= chr($opcodes{$tempopcode}+93).&randoperand();
     }
     elsif ($tempopcode eq 'setM')
     {
       $chars .= chr($opcodes{$tempopcode}+93).&randoperand();
     }
     elsif ($tempopcode eq 'readchar')
     {
       $chars .= chr($opcodes{$tempopcode}+93).&randoperand();
     }
     elsif ($tempopcode eq 'cmpIsLF')
     {
       $chars .= chr($opcodes{$tempopcode}+93).&randoperand();
     }
     elsif ($tempopcode eq 'cmpIsEOF')
     {
       $chars .= chr($opcodes{$tempopcode}+93).&randoperand();
     }
     elsif ($tempopcode eq 'cmp')
     {
       $chars .= chr($opcodes{$tempopcode}+93).$operand;
     }
     elsif ($tempopcode eq 'cmpIsQuote')
     {
       $chars .= chr($opcodes{$tempopcode}+93).&randoperand();
     }
     elsif ($tempopcode eq 'cmpIsSpace')
     {
       $chars .= chr($opcodes{$tempopcode}+93).' ';
     }
     elsif ($tempopcode eq 'cmpIsTab')
     {
       $chars .= chr($opcodes{$tempopcode}+93).&randoperand();
     }
     elsif ($tempopcode eq 'cmpLastIsCR')
     {
       $chars .= chr($opcodes{$tempopcode}+93).&randoperand();
     }
     elsif ($tempopcode eq 'cmpIsCR')
     {
       $chars .= chr($opcodes{$tempopcode}+93).&randoperand();
     }
     elsif ($tempopcode eq 'cmpLastIsLF')
     {
       $chars .= chr($opcodes{$tempopcode}+93).&randoperand();
     }
     elsif ($tempopcode eq 'branch')
     {
        if ($labels{$operand} < ($num + 1))
        {
           if (($num+1 - $labels{$operand} + 32) > 126) {die ("branch up too far $num\n");}
           if (($num+1 - $labels{$operand} + 32) == 34) {die ("branch up illegal char $num\n");}
           if (($num+1 - $labels{$operand} + 32) == 92) {die ("branch up illegal char $num\n");}
           $chars .= chr($opcodes{"branchUp"}+93).chr($num+1 - $labels{$operand} + 32);
        }
        else
        {
           if (($labels{$operand} - $num - 1 + 32) > 126) {die ("branch down too far $num\n");}
           if (($labels{$operand} - $num - 1 + 32) == 34) {die ("branch up illegal char $num\n");}
           if (($labels{$operand} - $num - 1 + 32) == 92) {die ("branch up illegal char $num\n");}
           $chars .= chr($opcodes{"branchDn"}+93).chr($labels{$operand} - $num - 1 + 32);
        }
     }
     elsif ($tempopcode eq 'goto')
     {
        if ($labels{$operand} < ($num + 1))
        {
           if (($num+1 - $labels{$operand} + 32) > 126) {die ("goto up too far $num\n");}
           if (($num+1 - $labels{$operand} + 32) == 34) {die ("goto up illegal char $num\n");}
           if (($num+1 - $labels{$operand} + 32) == 92) {die ("goto up illegal char $num\n");}
           $chars .= chr($opcodes{"gotoUp"}+93).chr($num+1 - $labels{$operand} + 32);
        }
        else
        {
           if (($labels{$operand} - $num - 1 + 32) > 126) {die ("goto down too far $num\n");}
           if (($labels{$operand} - $num - 1 + 32) == 34) {die ("goto up illegal char $num\n");}
           if (($labels{$operand} - $num - 1 + 32) == 92) {die ("goto up illegal char $num\n");}
           $chars .= chr($opcodes{"gotoDn"}+93).chr($labels{$operand} - $num - 1 + 32);
        }
     }
     elsif ($tempopcode eq 'addMToA')
     {
       $chars .= chr($opcodes{$tempopcode}+93).&randoperand();
     }
     elsif ($tempopcode eq 'return')
     {
       $chars .= chr($opcodes{$tempopcode}+93).&randoperand();
     }
     elsif ($tempopcode eq 'cmpLast')
     {
       $chars .= chr($opcodes{$tempopcode}+93).$operand;
     }
     elsif ($tempopcode eq 'cmpLastBackSlash')
     {
       $chars .= chr($opcodes{$tempopcode}+93).&randoperand();
     }
     elsif ($tempopcode eq 'cmpLastLastBackSlash')
     {
       $chars .= chr($opcodes{$tempopcode}+93).&randoperand();
     }
     else {die("$tempopcode temp op code not found");}
  }
}
close(FIL);
if (length($chars) % 36 != 0)
{
  my $remaining = int((length($chars)/36)+1)*36 - length($chars);
  print "Need to add remaining $remaining\n";
  &remainingchars($remaining);
}

if ($chars =~ /\?\?/) {die("Error! Double ? detected\n");}
print "$chars\n\n";
my @listofchars = unpack("a36" x (length($chars)/36), $chars);
foreach(@listofchars) {print "\"$_\"\n";}

############################################
sub randoperand()
{
  return chr(rand(50) + 35);
}

############################################
sub remainingchars()
{
 my ($r) = @_;
 $r = $r/2;
 my $i;
 for ($i=0;$i<$r;$i++) {$chars.= chr(rand(32)+93).&randoperand();}
}

