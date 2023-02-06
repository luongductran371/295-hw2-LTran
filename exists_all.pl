use strict;
use warnings;

if (@ARGV < 2) {
  die "Usage: $0 <filename> <commit 1> <commit 2> ...\n";
}

my $filename = shift @ARGV;
my @commits = @ARGV;

foreach my $commit (@commits) {
  my $output = `git cat-file -t $commit`;
  if ($output !~ /commit/) {
    if ($output =~ /tree/) {
      print "$commit is a tree object, not a commit object\n";
    } else {
      print "$commit does not represent a valid GIT object\n";
    }
    exit 1;
  }

  $output = `git ls-tree $commit $filename`;
  if (!$output) {
    print "False\n";
    exit 0;
  }
}

print "True\n";
