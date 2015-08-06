#!/usr/bin/perl -w

use strict;

my @indent = (0, 0, 0);
my %hash_ind = (
    "seqcat" => $indent[0],
    "nseq" => $indent[1],
    "fseq" => $indent[2],
);
my $DEBUG = 0;

sub dprint {
    my ($name, $str) = @_;
    if ($DEBUG == 1)
    {
        print "[Debug] $name [$hash_ind{$name}>] $str \n";
    }
}
# -- Solution 1: 
# -- get a set of sequences and the length of each sequence is equal to n
# -- card(nseq(s,n)) = card(s)**n
# nseq({}, n)={<>}
# nseq(s, 0)={<>}
# nseq(s, 1)={<x> | x <- s}
# nseq(s, n)={ s1 ^ <x> | s1 <- nseq(s, n-1), x <- s}

sub seqcat
{
    my ($f, $b) = @_;

    dprint("seqcat", "$f, $b");
    $hash_ind{"seqcat"}++;
    $f =~ s/[<>]//g;
    $b =~ s/[<>]//g;
    $hash_ind{"seqcat"}--;
    return "<$f,$b>";
}

sub nseq
{
    my ($n, @s) = @_;
    my $size = @s;
    my @ss;

    dprint("nseq", "$n, $size");
    $hash_ind{"nseq"}++;

    if (($size == 0) || ($n == 0))
    {
        push(@ss,"<>"); 
    }

    if ($n == 1)
    {
        foreach my $e (@s)
        {
            push(@ss,"<$e>");
        }
    }
    else
    {
        foreach my $s1 (nseq($n-1, @s))
        {
            foreach my $e (@s)
            {
                push(@ss, seqcat($s1, $e));
            }
        }
    }

    $hash_ind{"nseq"}--;
    return @ss;
}

# 
# -- fseq: finite set of finite sequences and the length of each sequence is less than n
# -- card(fseq(s,n)) = s**0 + s**1 + ... + s**n
# fseq({}, 1) = {<>} 
# fseq(s, 1)  = union(nseq(s, 1), fseq({}, 1))
# fseq(s, n)  = union(fseq(s, n-1), nseq(s,n))

# usage
#   fseq size arr1 arr2
# i.e.
#   fseq 3 a b      # is equal to fseq({a,b},3)

sub fseq 
{
    my ($n, @s) = @_;
    my $size = @s;
    
    dprint("fseq", "$n, $size");
    $hash_ind{"fseq"}++;

    if ($n == 0)
    {
        die "the n of fseq(n, s) can not be zero."
    }

    if ($n == 1)
    {
        if ($size == 0)
        {
            print "<>,\n";
        }
        else
        {
            print "$_,\n" for nseq(1, @s);
            fseq(1, ());
        }
    }
    else
    {
        fseq($n-1, @s);
        print "$_,\n" for nseq($n, @s);
    }
    $hash_ind{"fseq"}++;
}

my $args = $#ARGV + 1;
my @s=();

if ($args < 2) {
    print "\nUsage[1]: fseq 1 null \n";
    print "Usage[2]: fseq size arr1 [arr2 ... ] \n";
    exit;
}

my $n = $ARGV[0];

for (my $i = 1; $i < $args; $i++)
{
    push(@s, $ARGV[$i]);
}

print "Tseq = {\n";
if ($n == 1 && $args == 2 && $ARGV[1] eq "null")
{
    fseq($n,());
}
else
{
    fseq($n, @s);
}

# add additional <> just for the reason that if there is , before }, it is syntactically wrong in CSP. So just add this and no special meaning
print "<>\n}\n";
