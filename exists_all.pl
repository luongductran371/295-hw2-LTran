use strict;
use warnings;

if (@ARGV < 2) {
  die "Usage: $0 <filename> <commit 1> <commit 2> ...\n";
}

my $file_name = shift @ARGV;
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

  my @commit_content = `git cat-file -p $commit`;

  my @tree = split(' ',$commit_content[0]);
  my $tree_sha = $tree[1];
  my $tree_content = `git cat-file -p $tree_sha`;

  my $exists = 0;

  foreach my $line (split /\n/, $tree_content) {
    my ($mode, $type, $sha1, $name) = split /\s+/, $line;
    if ($name eq $file_name) {
        $exists = 1;
    }
  }

  if($exists == 0){
    print "False\n";
    exit 0;
  }

  # $output = `git ls-tree $commit $filename`;  
  # if (!$output) {
  #   print "False\n";
  #   exit 0;
  # }
}

print "True\n";
