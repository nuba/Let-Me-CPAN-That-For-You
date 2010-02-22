#!/usr/bin/perl

use lib (
  '../lib',
  '../checkouts/Web-Simple/lib/',
  '../checkouts/HTML-Zoom/lib/',
);

use App::LMCTFY;
App::LMCTFY->run_if_script;
