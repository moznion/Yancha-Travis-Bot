#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use FindBin;
use Getopt::Long;
use JSON;
use Plack::Request;
use Yancha::Bot2;

sub response {
    my ($bot, $json) = @_;

    my $repos = $json->{repository};

    my $message = sprintf(
        "[%s] %s (%s) %s",
        $json->{status_message},
        $repos->{name},
        $json->{commit},
        $json->{build_url}
    );

    $bot->post($message);
    print "$message\n";
}

# Get configurations.
my $config = do("$FindBin::Bin/config.pl");

# Setting for host and port.
GetOptions( \my %option, qw/host=s port=i/, );
$config->{server} = {
    host => $option{host} || $config->{server}->{host},
    port => $option{port} || $config->{server}->{port},
};

my $bot = Yancha::Bot2->new($config);
my $app = sub {
    my $req = Plack::Request->new(shift);

    if ($req->method eq 'POST' and my $payload = $req->param('payload')) {
        my $json = decode_json($payload);
        response($bot, $json);
        return [200, [], ['']];
    }

    warn "[ERROR] $req\n";
    return [500, [], ['']];
};

$bot->up($app);
