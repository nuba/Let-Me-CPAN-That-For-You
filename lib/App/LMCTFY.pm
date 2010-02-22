package App::LMCTFY;

use Web::Simple __PACKAGE__;
use HTML::Zoom;

sub oops {
  return [ 500, [ 'Content-type', 'text/plain' ], [ 'Oops! Something is wrong. Please bug nuba or edenc on irc.perl.org about this!' ] ]
}

sub gotcha {
  return [ 500, [ 'Content-type', 'text/plain' ], [ 'HA! Gotcha!' ] ]
}

dispatch {
  sub (GET + /) {
    my $file = '../templates/start.html';
    return oops unless -f $file;
    [ 200, [ 'Content-type', 'text/html' ], [ do { local (@ARGV, $/) = $file; <> }  ] ]
  },

  sub (GET + /*|/*/|/*/*|/*/*/ ) {
    # catches /foo and /foo/ and /foo/bar and /foo/bar/
    # foo is the search query, bar is the search mode
    my($self, $query, $mode) = @_;

    $query = defined $query ? $query : '';
    $mode = defined $mode ? $mode : 'all';
    my %abbreviations = ( m => 'module', d => 'dist', a => 'author' );
    foreach my $short_form ( keys %abbreviations ) { $mode = $abbreviations{$short_form} if $mode eq $short_form };

    return gotcha unless (
      ($query =~ m/[\p{IsPrint}]*/)                # no funny stuff, just print(graph(alpha, num, punct), space)
      && ($query !~ m/'/)                          # no trowing a wrench in the javascript (TODO: decent javascript escaping)
      and ($mode =~ m/^(all|module|dist|author)$/) # accept these only
    );

    my $file = '../templates/lmctfy.html';
    return oops unless -f $file;
    my $template = do { local (@ARGV, $/) = $file; <> };

    [ 200, [ 'Content-type', 'text/html' ], 
      [ 
        HTML::Zoom
        ->from_html($template)
        ->select('#vars')
        ->replace_content(<<VARS)

    var query='$query';
    var mode='$mode';

VARS
        ->to_html
      ]
    ]
  },
  sub (POST + /) {
    [ 200, [ 'Content-type', 'text/plain' ], [ 'Placeholder, form posted' ] ]
  },
  sub () {
    # looks like I was thrown something else.
    # just redispatch to the start page
    redispatch_to '/';
  },
};

1
