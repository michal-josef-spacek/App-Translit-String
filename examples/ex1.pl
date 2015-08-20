#!/usr/bin/env perl

# Pragmas.
use strict;
use warnings;

# Modules.
use App::Translit::String;

# Run.
App::Translit::String->new->run;

# Output:
# Usage: /tmp/vm3pgIQWej [-h] [-r] [-t table] [--version]
#         string
# 
#         -h              Print help.
#         -r              Reverse transliteration.
#         -t table        Transliteration table (default value is 'ISO/R 9').
#         --version       Print version.