#!/usr/bin/env perl6

# find all the files that ~/.XCompose links to, and add them to a list of files that should be searched
my @files;
for grep /^include/, "$*HOME/.XCompose".IO.lines {
	my $xcompose = $_;
	$xcompose ~~ s/include //;
	$xcompose ~~ s|'%H'|$*HOME|;
	next if /'%L'/;
	$xcompose ~~ s:g/'"'//;
	@files.push: $xcompose.trim;
}

@files.map({ for .IO.lines { unless /^\s*<[#]>/ or /^\s*$/ {
	say $_;
}}
});
