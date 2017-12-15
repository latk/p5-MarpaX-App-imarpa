requires "English" => "0";
requires "Getopt::Long" => "0";
requires "Pod::Usage" => "0";
requires "feature" => "0";
requires "perl" => "v5.14.0";
requires "strict" => "0";
requires "warnings" => "0";
recommends "Cpanel::JSON::XS" => "0";
recommends "Data::Dump" => "0";
recommends "Marpa::R2" => "4";
recommends "YAML" => "0";

on 'build' => sub {
  requires "Module::Build" => "0.28";
};

on 'test' => sub {
  requires "FindBin" => "0";
  requires "Test::More" => "0";
};

on 'configure' => sub {
  requires "Module::Build" => "0.28";
};

on 'develop' => sub {
  requires "Dist::Zilla" => "5";
  requires "Dist::Zilla::Plugin::AutoPrereqs" => "0";
  requires "Dist::Zilla::Plugin::ExecDir" => "0";
  requires "Dist::Zilla::Plugin::ModuleBuild" => "0";
  requires "Dist::Zilla::Plugin::Prereqs" => "0";
  requires "Dist::Zilla::Plugin::VersionFromMainModule" => "0";
  requires "Dist::Zilla::PluginBundle::Author::AMON" => "0";
  requires "Pod::Coverage::TrustPod" => "0";
  requires "Software::License::GPL_3" => "0";
  requires "Test::Kwalitee::Extra" => "0";
  requires "Test::More" => "0";
  requires "Test::Perl::Critic" => "0";
  requires "Test::Pod" => "1.41";
  requires "Test::Pod::Coverage" => "1.08";
};
