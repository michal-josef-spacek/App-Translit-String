#!/usr/bin/env perl

use strict;
use warnings;

use App::Translit::String;

# Run.
@ARGV = ('Российская Федерация');
App::Translit::String->new->run;

# Output:
# Rossijskaja Federacija