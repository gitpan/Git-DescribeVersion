
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Use git-describe to show a repo's version",
  "AUTHOR" => "Randy Stauner <rwstauner\@cpan.org>",
  "BUILD_REQUIRES" => {
    "Exporter" => 0,
    "File::Find" => 0,
    "File::Temp" => 0,
    "Test::MockObject" => "1.09",
    "Test::MockObject::Extends" => "1.09",
    "Test::More" => "0.96"
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Git-DescribeVersion",
  "EXE_FILES" => [
    "bin/git-describe-version"
  ],
  "LICENSE" => "perl",
  "NAME" => "Git::DescribeVersion",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Getopt::Long" => 0,
    "strict" => 0,
    "version" => "0.82",
    "warnings" => 0
  },
  "VERSION" => "1.010",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



