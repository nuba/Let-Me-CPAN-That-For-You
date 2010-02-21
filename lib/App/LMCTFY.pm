package App::LMCTFY;

use Web::Simple __PACKAGE__;

sub oops {
  return [ 500, [ 'Content-type', 'text/plain' ], [ 'Oops! Something is wrong. Please bug nuba or edenc on irc.perl.org!' ] ]
}

dispatch {
  sub (GET + /) {
    my $file = "html/start.html";
    return oops unless -f $file;
    [ 200, [ 'Content-type', 'text/html' ], [ ${ \do { local (@ARGV, $/) = $file; <> } } ] ]
  },
      sub (GET + /*|/*/ ) {
  # catches /foo and /foo/
  # foo is the search query
  # must check for sane input, this'll end up on js running on the user's browser
    [ 200, [ 'Content-type', 'text/plain' ], [ join(' ', 'Placeholder, form filled with ', $_[1]) ] ]
  },
  sub (GET + /*/*|/*/*/ ) {
  # catches /foo/bar and /foo/bar/
  # foo is the search query
  # bar is the search index to use (modules, authors, etc)
  # must check for sane input, this'll end up on js running on the user's browser
    [ 200, [ 'Content-type', 'text/plain' ], [ join(' ', 'Placeholder, fill form with', $_[1], 'and', $_[2]) ] ]
  },
  sub (POST + /) {
    [ 200, [ 'Content-type', 'text/plain' ], [ 'Placeholder, form posted' ] ]
  },
  sub () {
  # looks like I was thrown something unexpected.
  # just redispatch to the start page
  redispatch_to '/';
  },
};

1
