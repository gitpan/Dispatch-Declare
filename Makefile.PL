use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Dispatch::Declare',
    AUTHOR              => 'Robert Boone <rlb@cpan.org>',
    VERSION_FROM        => 'lib/Dispatch/Declare.pm',
    ABSTRACT_FROM       => 'lib/Dispatch/Declare.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'version'    => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Dispatch-Declare-*' },
);
