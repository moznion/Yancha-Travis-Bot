requires 'Getopt::Long';
requires 'JSON';
requires 'Plack::Request';
requires 'Yancha::Bot2', '0.03';

on test => sub {
    requires 'Test::More', '0.98';
};
