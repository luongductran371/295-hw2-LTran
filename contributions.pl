use strict;
use warnings;

my @logs = `git log --pretty=format:"%ae,%ct,%s"`;

my %contributions;

foreach my $log (@logs) {
    my ($email, $timestamp, $commit_message) = split(',', $log);
    if (exists $contributions{$email}) {
        $contributions{$email}{'count'}++;
        $contributions{$email}{'first_commit'} = $timestamp if $timestamp < $contributions{$email}{'first_commit'};
    } else {
        $contributions{$email} = {
            'count' => 1,
            'first_commit' => $timestamp,
            'latest_commit' => $timestamp,
        };
    }
}

foreach my $email (sort keys %contributions) {
    my $count = $contributions{$email}{'count'};
    my $first_commit = $contributions{$email}{'first_commit'};
    my $latest_commit = $contributions{$email}{'latest_commit'};
    print "$email , $count , " . localtime($first_commit) . " , " . localtime($latest_commit) . "\n";
}
