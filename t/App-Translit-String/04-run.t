use strict;
use warnings;

use App::Translit::String;
use Test::More 'tests' => 4;
use Test::NoWarnings;
use Test::Output;
use Unicode::UTF8 qw(decode_utf8);

# Test.
@ARGV = (
	decode_utf8('Российская Федерация'),
);
my $right_ret = <<'END';
Rossijskaja Federacija
END
stdout_is(
	sub {
		App::Translit::String->new->run;
		return;
	},
	$right_ret,
	'Run with transliteration.',
);

# Test.
@ARGV = (
	'-r',
	'Rossijskaja Federacija',
);
$right_ret = <<'END';
Российскайа Федерацийа
END
stdout_is(
	sub {
		App::Translit::String->new->run;
		return;
	},
	$right_ret,
	'Run with reverse transliteration.',
);

# Test.
@ARGV = (
	'-h',
);
$right_ret = <<'END';
Usage: t/App-Translit-String/04-run.t [-h] [-r] [-t table] [--version]
	string

	-h		Print help.
	-r		Reverse transliteration.
	-t table	Transliteration table (default value is 'ISO/R 9').
	--version	Print version.
END
stderr_is(
	sub {
		App::Translit::String->new->run;
		return;
	},
	$right_ret,
	'Run help.',
);
