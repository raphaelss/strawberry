#!/usr/bin/env perl
# This file is parte of Strawberry, a html/js app for musical texture density
# planning released under the MIT license terms.
# Copyright (c) 2015 Raphael Sousa Santos, http://www.raphaelss.com

use strict;
use warnings;

sub write_js {
	my $out = shift;
	my $file = shift;
	open(my $in, '<', $file) || die "Could not open file: $!";
	print $out '<script type="text/javascript">';
	while (<$in>) {
		print $out $_;
	}
	print $out '</script>';
	close($in);
};

sub write_css {
	my $out = shift;
	my $file = shift;
	open(my $in, '<', $file) || die "Could not open file: $!";
	print $out '<style type="text/css">';
	while (<$in>) {
		print $out $_;
	}
	print $out '</style>';
	close($in);
};

my $html_in = 'densidade.html';
my $js_in = 'densidade.js';
my $html_out = 'strawberry.html';

my $jquery = 'ext/jquery.min.js';
my $bootstrap_css = 'ext/bootstrap.min.css';
my $bootstrap_js = 'ext/bootstrap.min.js';

my $js_line = "    <script src=\"densidade.js\"></script>\n";
my $jquery_line = "    <script src=\"https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js\"></script>\n";
my $bootstrap_css_line = "    <link href=\"http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css\" rel=\"stylesheet\">\n";
my $bootstrap_js_line = "    <script src=\"http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js\"></script>\n";

open(my $out, '>', $html_out) || die "Could not open file: $!";
open(my $html, '<', $html_in) || die "Could not open file: $!";

while (<$html>) {
	if ($_ eq $js_line) {
		write_js($out, $js_in);
	} elsif ($_ eq $jquery_line) {
		write_js($out, $jquery);
	} elsif ($_ eq $bootstrap_css_line) { 
		write_css($out, $bootstrap_css);
	} elsif ($_ eq $bootstrap_js_line) {
		write_js($out, $bootstrap_js);
	} else {
		print $out $_;
	}
}

close($html);
close($out);
