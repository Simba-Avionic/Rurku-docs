#!/usr/bin/env perl
# Sanitize latexdiff output so booktabs/\noalign rules are never preceded by
# \DIF* markup (causes "Misplaced \noalign" with xltabular/longtable).
#
# Inside tabular-like environments: drop deleted chunks and unwrap additions
# so only the new-file table remains.
use strict;
use warnings;

my $file = shift @ARGV or die "usage: $0 file.tex\n";
open my $fh, '<:raw', $file or die "$file: $!";
local $/;
my $tex = <$fh>;
close $fh;

my $envs = qr/(?:tabularx|xltabular|longtable|reqtabular|tabular\*?)/;

sub extract_brace_group {
    # $_[0] = string, $_[1] = index of opening '{'
    my ($s, $i) = @_;
    return undef if $i >= length($s) || substr($s, $i, 1) ne '{';
    my $depth = 0;
    for my $j ($i .. length($s) - 1) {
        my $c = substr($s, $j, 1);
        if ($c eq '{') { $depth++ }
        elsif ($c eq '}') {
            $depth--;
            return substr($s, $i + 1, $j - $i - 1) if $depth == 0;
        }
    }
    return undef;
}

sub strip_cmd_groups {
    my ($body, $cmd, $keep) = @_;
    # Remove or unwrap \cmd{...} with balanced braces
    my $out = '';
    my $i = 0;
    my $pat = qr/\\Q$cmd\\E/;
    # manual scan
    while ($i < length($body)) {
        if (substr($body, $i) =~ /^\Q$cmd\E\{/) {
            my $open = $i + length($cmd);
            my $inner = extract_brace_group($body, $open);
            if (defined $inner) {
                my $end = $open + 1 + length($inner) + 1;  # { inner }
                $out .= $inner if $keep;
                $i = $end;
                next;
            }
        }
        $out .= substr($body, $i, 1);
        $i++;
    }
    return $out;
}

sub strip_dif {
    my ($body) = @_;
    # Remove deleted blocks (begin/end wrappers)
    $body =~ s/\\DIFdelbeginFL.*?\\DIFdelendFL//sg;
    $body =~ s/\\DIFdelbegin.*?\\DIFdelend//sg;
    # Remove deleted command groups
    $body = strip_cmd_groups($body, '\\DIFdelFL', 0);
    $body = strip_cmd_groups($body, '\\DIFdel', 0);
    # Comment-style deleted commands
    $body =~ s/^%DIFDELCMD.*\n//mg;
    $body =~ s/%DIFDELCMD.*//g;
    # Unwrap additions
    $body =~ s/\\DIFaddbeginFL|\\DIFaddendFL|\\DIFaddbegin|\\DIFaddend//g;
    $body = strip_cmd_groups($body, '\\DIFaddFL', 1);
    $body = strip_cmd_groups($body, '\\DIFadd', 1);
    return $body;
}

my $n = 0;
$tex =~ s{
    (\\begin\{($envs)\}(?:\{(?:[^{}]|\{[^{}]*\})*\})*)
    (.*?)
    (\\end\{\2\})
}{
    my ($begin, $name, $body, $end) = ($1, $2, $3, $4);
    if ($body =~ /\\DIF/) {
        $n++;
        $begin . strip_dif($body) . $end;
    } else {
        $begin . $body . $end;
    }
}sgex;

# Residual: \DIF* immediately before booktabs / \end{...}
$tex =~ s/\\DIF(?:delend|addbegin|addend|delbegin)(?:FL)?\s*(?=\\(?:toprule|midrule|bottomrule|cmidrule|hline|end\{(?:tabularx|xltabular|longtable|reqtabular)))//g;

open my $out, '>:raw', $file or die "$file: $!";
print {$out} $tex;
close $out;
print STDERR "latexdiff-sanitize: cleaned DIF markup in $n table environment(s) in $file\n";
