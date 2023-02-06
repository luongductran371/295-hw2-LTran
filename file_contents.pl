
use strict;
use warnings;

my $file = shift;

if (! -e $file) {
    print "Error: file does not exist\n";
    exit;
}

my $sha = `git log --pretty=format:'%H' -n 1 $file`;
chomp $sha;

my $author = `git log --pretty=format:'%an' -n 1 $file`;
chomp $author;

my $author_email = `git log --pretty=format:'%ae' -n 1 $file`;
chomp $author_email;

print "Author: $author $author_email\n\n";
print "SHA-1 for $file: $sha\n\n";

open(my $fh, "<", $file) or die "Error opening file: $!";
while (my $line = <$fh>) {
    print $line;
}

close $fh;