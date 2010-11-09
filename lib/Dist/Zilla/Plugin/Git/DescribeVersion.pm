package Dist::Zilla::Plugin::Git::DescribeVersion;
BEGIN {
  $Dist::Zilla::Plugin::Git::DescribeVersion::VERSION = '0.005011';
}
# ABSTRACT: provide a version number by using the git-describe command

# I don't know much about Dist::Zilla or Moose.
# This code copied/modified from Dist::Zilla::Plugin::Git::NextVersion.
# Thanks rjbs and jquelin!

use strict;
use warnings;
use Dist::Zilla 4 ();
use Git::DescribeVersion ();
use Moose;
use namespace::autoclean 0.09;

with 'Dist::Zilla::Role::VersionProvider';

# -- attributes

	while( my ($name, $default) = each %Git::DescribeVersion::Defaults ){
has $name => ( is => 'ro', isa=>'Str', default => $default );
	}

# -- role implementation

sub provide_version {
	my ($self) = @_;

	# override (or maybe needed to initialize)
	return $ENV{V} if exists $ENV{V};

	# less overhead to use %Defaults than MOP meta API
	my $opts = { map { $_ => $self->$_() }
		keys %Git::DescribeVersion::Defaults };

	my $new_ver = eval {
		Git::DescribeVersion->new($opts)->version;
	};

	$self->log_fatal("Could not determine version from tags: $@")
		unless defined $new_ver;

	$self->log("Git described version as $new_ver");

	$self->zilla->version("$new_ver");
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;


__END__
=pod

=head1 NAME

Dist::Zilla::Plugin::Git::DescribeVersion - provide a version number by using the git-describe command

=head1 VERSION

version 0.005011

=head1 SYNOPSIS

In your F<dist.ini>:

	[Git::DescribeVersion]
	match_pattern  = v[0-9]*     ; this is the default

=head1 DESCRIPTION

This does the L<Dist::Zilla::Role::VersionProvider> role.
It uses L<Git::DescribeVersion> to count the number of commits
since the last tag (matching I<match_pattern>) or since the initial commit,
and uses the result as the I<version> parameter for your distribution.

The plugin accepts the same options as the base module's constructor.
See L<Git::DescribeVersion/OPTIONS>.

You can also set the C<V> environment variable to override the new version.
This is useful if you need to bump to a specific version.  For example, if
the last tag is 0.005 and you want to jump to 1.000 you can set V = 1.000.

  $ V=1.000 dzil release

=for Pod::Coverage provide_version

=head1 SEE ALSO

=over 4

=item *

L<Git::DescribeVersion>

=item *

L<Dist::Zilla>

=item *

L<Dist::Zilla::Plugin::Git::NextVersion>

=back

This code copied/modified from L<Dist::Zilla::Plugin::Git::NextVersion>.

Thanks I<rjbs> and I<jquelin> (and many others)!

=head1 AUTHOR

Randy Stauner <rwstauner@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Randy Stauner.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

