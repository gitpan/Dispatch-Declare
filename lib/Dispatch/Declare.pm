package Dispatch::Declare;

use warnings;
use strict;
use Carp;

use version; our $VERSION = qv('0.0.4');

sub import {
    no strict 'refs';
    *{ caller() . '::declare'   } = \&declare;
    *{ caller() . '::undeclare' } = \&undeclare;
    *{ caller() . '::run'       } = \&run;
}

my $stash = {};

sub declare($&) {
    my $key  = shift;
    my $code = shift;

    $stash->{ uc $key } = $code;
}

sub undeclare($) {
    my $key  = shift;

    delete $stash->{ uc $key } if exists $stash->{uc $key};
}

sub run {
    my $key = shift;
    if (exists $stash->{uc $key}) {
        return $stash->{uc $key}->();
    }
    elsif (exists $stash->{'DEFAULT'}) {
        $stash->{'DEFAULT'}->();
    }
}



1; # Magic true value required at end of module
__END__

=head1 NAME

Dispatch::Declare - Build a hash based dispatch table declaratively


=head1 VERSION

This document describes Dispatch::Declare version 0.0.3


=head1 SYNOPSIS

    use Dispatch::Declare;

    my $action = 'ADDUSER';

    declare REPAIRDB => sub {
        print 'This is a REPAIRDB test' . "\n";
    };

    declare ADDUSER => sub {
        print 'This is a ADDUSER test' . "\n";
    };

    run $action;
  
  
=head1 DESCRIPTION

    Large if-else statement can be trouble. Or as the PBP calls them cascading ifs. I also
    find that large hash/dispatch tables can lead to trouble too. If you make a syntax error the line given
    could be at the end of the control structure. I thoguht most of the problems could be solved with
    a little syntax.


=head1 INTERFACE 

    There are only two subroutines exported, declare and run.
    declare is where you setup you dispatch table.

=over 4

=item declare

    declare KEY1 => sub {
        ...
    }
    
    declare KEY2 => sub {
        ...
    }

=item undeclare

   undeclare 'KEY1';

   Now KEY1 have been remove from the table.

=item run

    Then to call your action:
    my $key = 'KEY1';
    run $key
    
    That all there is to it.

=item DEFAULT key
    If you make one of your keys DEFAULT it will be executed if no other keys match.

=back

=head1 CONFIGURATION AND ENVIRONMENT
  
Dispatch::Declare requires no configuration files or environment variables.

=head1 INCOMPATIBILITIES

None reported.


=head1 BUGS AND LIMITATIONS
1. The value part of the declare must be a code ref.
2. Only one dispatch table can be used.

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-dispatch-declare@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.


=head1 AUTHOR

Robert Boone  C<< <rlb@cpan.org> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2007, Robert Boone C<< <rlb@cpan.org> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.

