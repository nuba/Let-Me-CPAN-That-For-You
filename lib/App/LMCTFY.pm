package App::LMCTFY;

use Web::Simple __PACKAGE__;

dispatch {
  sub (GET + /) {
    [ 200, [ 'Content-type', 'text/plain' ], [ 'Welcome' ] ]
  },
  sub (GET + /*|/*/) {
    [ 200, [ 'Content-type', 'text/plain' ], [ join(' ', 'Placeholder, form filled with ', $_[1]) ] ]
  },
  sub (GET + /*/*|/*/*/ ) {
    [ 200, [ 'Content-type', 'text/plain' ], [ join(' ', 'Placeholder, fill form with', $_[1], 'and', $_[2]) ] ]
  },
  sub (POST + /) {
    [ 200, [ 'Content-type', 'text/plain' ], [ 'Placeholder, form posted' ] ]
  },
  sub () {
    [ 200, [ 'Content-type', 'text/plain' ], [ 'Placeholder - catch-all' ] ]
  },
};

1
