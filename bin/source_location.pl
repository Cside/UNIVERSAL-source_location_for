#!/usr/bin/env perl
use strict;
use warnings;
use Term::ANSIColor qw(colored);
use UNIVERSAL::require;
use UNIVERSAL::source_location_for;
my ($class, $method) = @ARGV;
unless ($class && $method) {
    print <<'...';
USAGE:
    $ source_location.pl Module method
...
    exit;
}

$class->require or die $@;
my ($file, $line) = do {
    local $SIG{__WARN__} = sub {};
    $class->source_location_for($method)
};

unless (defined($file) && defined($line)) {
    print colored(qq|method "${class}::$method" is not found.|, 'red'), "\n";
    exit;
}

print colored('FILENAME ', 'green') .  "$file\n";
print colored('LINE     ', 'green') .  "$line\n";
