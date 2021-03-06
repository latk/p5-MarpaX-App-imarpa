
# This file was automatically generated by Dist::Zilla::Plugin::ModuleBuild v6.010.
use strict;
use warnings;

use Module::Build 0.28;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.28"
  },
  "configure_requires" => {
    "Module::Build" => "0.28"
  },
  "dist_abstract" => "use the Marpa parser on the command line",
  "dist_author" => [
    "Lukas Atkinson"
  ],
  "dist_name" => "MarpaX-App-imarpa",
  "dist_version" => "0.001000",
  "license" => "gpl",
  "module_name" => "MarpaX::App::imarpa",
  "recommends" => {
    "Cpanel::JSON::XS" => 0,
    "Data::Dump" => 0,
    "Marpa::R2" => 4,
    "YAML" => 0
  },
  "recursive_test_files" => 1,
  "requires" => {
    "English" => 0,
    "Getopt::Long" => 0,
    "Marpa::R2" => 0,
    "Pod::Usage" => 0,
    "feature" => 0,
    "perl" => "v5.14.0",
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => [
    "bin/imarpa"
  ],
  "test_requires" => {
    "FindBin" => 0,
    "Test::More" => 0
  }
);


my %fallback_build_requires = (
  "FindBin" => 0,
  "Module::Build" => "0.28",
  "Test::More" => 0
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  delete $module_build_args{test_requires};
  $module_build_args{build_requires} = \%fallback_build_requires;
}

my $build = Module::Build->new(%module_build_args);


$build->create_build_script;
