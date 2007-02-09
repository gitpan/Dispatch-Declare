use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Dispatch::Declare',
    license             => 'perl',
    dist_author         => 'Robert Boone <robert@rlb3.com>',
    dist_version_from   => 'lib/Dispatch/Declare.pm',
    requires => {
        'Test::More' => 0,
        'version'    => 0,
    },
    add_to_cleanup      => [ 'Dispatch-Declare-*' ],
);

$builder->create_build_script();
