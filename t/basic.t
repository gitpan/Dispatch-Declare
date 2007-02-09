use Test::More tests => 3;

BEGIN {
    use_ok( 'Dispatch::Declare' );
}

my $action = 'TEST1';

declare TEST1 => sub {
    return 'ONE'
};

declare TEST2 => sub {
    return 'TWO'
};

my $result = run $action;

is $result, 'ONE', 'Correct action result';
isnt $result, 'TWO', 'Incorrect action result not sent';