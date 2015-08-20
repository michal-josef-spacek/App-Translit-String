package App::Translit::String;

# Pragmas.
use strict;
use warnings;

# Modules.
use English;
use Error::Pure qw(err);
use Getopt::Std;
use Lingua::Translit;

# Version.
our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Process arguments.
	$self->{'_opts'} = {
		'h' => 0,
		't' => 'ISO/R 9',
	};
	if (! getopts('hrt:', $self->{'_opts'}) || @ARGV < 1
		|| $self->{'_opts'}->{'h'}) {

		print STDERR "Usage: $0 [-h] [-r] [-t table] [--version]\n\t".
			"string\n\n";
		print STDERR "\t-h\t\tPrint help.\n";
		print STDERR "\t-r\t\tReverse transliteration.\n";
		print STDERR "\t-t table\tTransliteration table (default ".
			"value is 'ISO/R 9').\n";
		print STDERR "\t--version\tPrint version.\n";
		exit 1;
	}
	$self->{'_string'} = $ARGV[0];

	# Object.
	return $self;
}

# Run script.
sub run {
	my $self = shift;
	my $ret;
	eval {
		my $tr = Lingua::Translit->new($self->{'_opts'}->{'t'});
		if ($self->{'_opts'}->{'r'}) {
			if ($tr->can_reverse) {
				$ret = $tr->translit_reverse(
					$self->{'_string'});
			} else {
				err 'No reverse transliteration.';
			}
		} else {
			$ret = $tr->translit($self->{'_string'});
		}
	};
	if ($EVAL_ERROR) {
		err 'Cannot transliterate string.',
			'Error', $EVAL_ERROR;
	}
	print "$ret\n";
	return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

App::Translit::String - Perl class for translit-string application.

=head1 SYNOPSIS

 use App::Translit::String;
 my $obj = App::Translit::String->new;
 $obj->run;

=head1 METHODS

=over 8

=item C<new()>

 Constructor.

=item C<run()>

 Run.

=back

=head1 ERRORS

 new():
         From Class::Utils:
                 Unknown parameter '%s'.

 run():
         Cannot transliterate string.

=head1 EXAMPLE1

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

=head1 EXAMPLE2

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use App::Translit::String;

 # Run.
 @ARGV = ('Российская Федерация');
 App::Translit::String->new->run;

 # Output:
 # Rossijskaja Federacija

=head1 DEPENDENCIES

L<English>,
L<Error::Pure>,
L<Getopt::Std>,
L<Lingua::Translit>.

=head1 REPOSITORY

L<https://github.com/tupinek/App-Translit-String>.

=head1 AUTHOR

Michal Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

 © 2015 Michal Špaček
 BSD 2-Clause License

=head1 VERSION

0.01

=cut
