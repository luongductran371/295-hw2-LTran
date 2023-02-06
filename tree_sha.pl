use strict;
use warnings;

my $commit_sha = $ARGV[0];

# Use the `git` command line tool to get the SHA-1 code for the tree object
my $tree_sha = `git rev-parse $commit_sha^{tree}`;
chomp $tree_sha;

print "$tree_sha\n";
