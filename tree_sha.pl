use strict;
use warnings;

my $commit_sha = $ARGV[0];

my $tree_sha = `git rev-parse $commit_sha^{tree}`;
chomp $tree_sha;

print "$tree_sha\n";

hi;
