use strict;
use warnings;

my $commit_sha = $ARGV[0];

my @commit_content = `git cat-file -p $commit_sha`;

my @tree = split(' ',$commit_content[0]);
my $tree_sha = $tree[1];

print "$tree_sha\n";
