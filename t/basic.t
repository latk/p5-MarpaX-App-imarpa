#!/usr/bin/env perl
use strict;
use warnings;

use FindBin;
my $imarpa = "$FindBin::Bin/../bin/imarpa";

use Test::More;

require_ok $imarpa;

# TODO: more tests

done_testing;
