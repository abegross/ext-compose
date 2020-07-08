#!/usr/bin/env perl6
use Clipboard:from<Perl5>;

my %specials = 
		'⎄' => 'Multi_key',
		'%' => 'percent',
		'&' => 'ampersand',
		'-' => 'minus',
		'_' => 'underscore',
		'>' => 'greater',
		'<' => 'less',
		',' => 'comma',
		'.' => 'period',
		'$' => 'dollar',
		'!' => 'exclam',
		'?' => 'question',
		'+' => 'plus',
		'/' => 'slash',
		'#' => 'numbersign',
		'@' => 'at',
		'|' => 'bar',
		'`' => 'grave',
		'~' => 'asciitilde',
		'^' => 'asciicircum',
		'(' => 'parenleft',
		')' => 'parenright',
		'[' => 'bracketleft',
		']' => 'bracketright',
		'{' => 'braceleft',
		'}' => 'braceright',
		"'" => 'apostrophe',
		'"' => 'quotedbl',
		'\\'=> 'backslash',
		':' => 'colon',
		';' => 'semicolon',
		'=' => 'equal',
		' ' => 'space',
		'*' => 'asterisk',
		;

sub USAGE() {
	put Q:c:to/END/;
	{$*USAGE}

	regular:
		the regular abcs or wtvr that will be typed out
		each letter in `regular` corresponds to the respective letter in `composed`
		example: --regular="0123456789"

	multiple:
		to make more than one character in `regular` correspond to a single 
		letter in `composed`, add this switch - now a space defines each 
		sequence in `regular`
		example: --multiple --regular="0a 1b 2C 3 4 5  6 7h 8i 9#"

	composed:
		the characters that compose spits out
		example: --composed="𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"

	sequence:
		the sequence ull type out using the compose key.
		"⎄" means the compose key. 
		⎄ can be accessed through '⎄[(])'
		★ is what will be replaced with whats in regular
		★ can be accessed through '⎄**'
		example: --sequence="⎄★|"
	
	Usage Examples:
		raku {$*PROGRAM-NAME} --multiple --regular="0a 1b 2C 3 4 5  6 7h 8i 9#" --sequence="⎄★|" --composed="𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
		raku {$*PROGRAM-NAME} --regular="aou" --composed="𝒂𝒐𝒖" --sequence="⎄/★"
	END
}

sub MAIN ( Str:D :$regular! is rw, Bool :$multiple, Str:D :$composed!, Str:D :$sequence! is rw  ) {
	$regular .= split($multiple ?? " " !! "", :skip-empty);

	my $replace := {
		#replace each symbol with its named counterpart
		.split("",:skip-empty).map({ "<{%specials{$_}//$_}>" }).join(" ");
	}
	$sequence = $replace($sequence);

	if $regular.elems == $composed.chars {
		my %sequences;
		for ^$regular.elems -> $pos {
			my $current_sequence = $sequence.subst('<★>', $replace($regular[$pos]));
			my $desc =
				"\t: \"{$composed.substr($pos,1)}\"" ~
				" U{$composed.substr($pos,1).ord.base(16)}" ~
				"\t# {$composed.substr($pos,1).uniname}";

			%sequences.push: $current_sequence => $desc;
		}

		# format the output nicely
		my $len = max map { .chars }, %sequences.keys;
		my @sequences = map { sprintf("%-"~$len~"s %s", .key, .value) }, %sequences.sort({.value});

		put @sequences.join("\n");
		Clipboard.copy_to_all_selections(@sequences.join("\n"));
	} else {
		put "regular ({$regular.elems}) is not equal to composed ({$composed.chars})"
	}
}
