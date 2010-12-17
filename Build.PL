
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  'build_requires' => {
    'Exporter' => '0',
    'File::Find' => '0',
    'File::Temp' => '0',
    'Module::Build' => '0.3601',
    'Test::MockObject' => '1.09',
    'Test::MockObject::Extends' => '1.09',
    'Test::More' => '0.96'
  },
  'configure_requires' => {
    'Module::Build' => '0.3601'
  },
  'dist_abstract' => 'Use git-describe to show a repo\'s version',
  'dist_author' => [
    'Randy Stauner <rwstauner@cpan.org>'
  ],
  'dist_name' => 'Git-DescribeVersion',
  'dist_version' => '1.001011',
  'license' => 'perl',
  'module_name' => 'Git::DescribeVersion',
  'recommends' => {},
  'recursive_test_files' => 1,
  'requires' => {
    'perl' => '5.006',
    'version' => '0.82'
  },
  'script_files' => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
