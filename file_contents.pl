
use strict;
use warnings;

my $file_name = shift;

if (! -e $file_name) {
    print "Error: file does not exist\n";
    exit;
}

open(my $fh, '<', '.git/HEAD') or die "Could not open file: $!";
my $content = do { local $/; <$fh> };
close($fh);
my @head_ref_array = split(' ', $content);
$content = $head_ref_array[1];

open($fh, '<', ".git/$content") or die "Could not open file: $!";
$content = do { local $/; <$fh> };
close($fh);

my $commit_content = `git cat-file -p $content`;

if ($commit_content =~ /^author\s+(.+)\s+<(.+)>/m) {
    my $author_name = $1;
    my $author_email = $2;
    $author_name =~ s/^\s+//;  # Remove leading whitespace
    $author_name =~ s/\s+$//;  # Remove trailing whitespace
    print "Author: $author_name $author_email\n\n";
} else {
    print "Could not extract author's name and email from commit content.\n";
}

my @commit_content = `git cat-file -p $content`;

my @tree = split(' ',$commit_content[0]);
my $tree_sha = $tree[1];
my $tree_content = `git cat-file -p $tree_sha`;

my $file_sha1;
foreach my $line (split /\n/, $tree_content) {
    my ($mode, $type, $sha1, $name) = split /\s+/, $line;
    if ($name eq $file_name) {
        $file_sha1 = $sha1;
        last;
    }
}

if (defined $file_sha1) {
    print "SHA-1 for $file_name: $file_sha1\n\n";
} else {
    print "File not found in tree.\n";
}

open($fh, "<", $file_name) or die "Error opening file: $!";
while (my $line = <$fh>) {
    print $line;
}

close $fh;
