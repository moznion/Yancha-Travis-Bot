#!/usr/bin/env perl

use strict;
use warnings;
use Plack::Request;

sub response {
    my ($bot, $json) = @_;
}

my $bot;

my $app = sub {
    my $req = Plack::Request->new(shift);

    if ($req->method eq 'POST') {
        my $json = $req->param;
        use Data::Dumper::Concise; warn Dumper($json); # TODO remove
        response($bot, $json);
        return [200, [], ['']];
    }
};
