#!/usr/bin/env raku

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
	  make ‘⎄/a’ = 𝒂, ‘⎄/b’ = 𝒃, and ‘⎄/c’ = 𝒄

		raku {$*PROGRAM-NAME} --regular="aou" --composed="𝒂𝒐𝒖" --sequence="⎄/★"

	  You can use the arrow symbols to denote the arrow keys:

		raku {$*PROGRAM-NAME} --multiple --regular="↑← ↑→ ↓← ↓→" --composed="↰↱↲↳" --sequence="⎄★"

	  make ‘⎄0a|’ = 𝟘 etc

		raku {$*PROGRAM-NAME} --multiple --regular="0a 1b 2C 3 4 5  6 7h 8i 9#" --sequence="⎄★|" --composed="𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
	END
}

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
		'↑' => 'Up',
		'↓' => 'Down',
		'→' => 'Right',
		'←' => 'Left',
		'␣' => 'space',
		'★' => '★',
		;


unit sub MAIN ( 
	Bool  :m(:$multiple),			#= allow more than one `regular` per `composed`
	:r(:$regular)! is copy,			#= the letter you type out
	:c(:$composed)! is copy,		#= the letter xcompose spits out
	Str:D :s(:$sequence)! is copy	#= the sequence you type (including the ⎄ key)
);

$regular  .= split($multiple ?? " " !! "", :skip-empty);

# if theres twice as many characters in $composed as there is in $regular
# then split by spaces, not by each letter
$composed .= split($composed.chars == $regular.elems*2-1 ?? " " !! "",:skip-empty);

#| replace each symbol with its named counterpart, or its codepoint
sub replace($_) {
	state %cache; # caches the symbols so it doesnt need to recompute each character (30% faster)
	.split("",:skip-empty).map({
		my ($key,$value) = $_,"";
		if %cache{$key}:exists { 
			%cache{$key}
		} else {
			if %specials{$_} or /<[A..Za..z0..9]>/ {
				$value = '<'~(%specials{$_}//$_)~'>'
			} else {
				$value = '<U'~(.ord.base(16))~'>'
			}	
			%cache{$key} = $value;
		}
	}).join(" ");
}
$sequence = replace($sequence);

if $regular.elems == $composed.elems {
	# create a hash between each sequence in `regular` and `composed`
	my %sequences = ($regular »=>» $composed).map: -> $this {
		my $current-sequence = $sequence.subst('<★>', replace($this.key));
		my $desc =
			"\t: \"{$this.value}\"" ~
			" U{$this.value.ord.base(16)}" ~
			"\t# {$this.value.uniname}";
		$current-sequence => $desc;
	};

	# format the output nicely
	my $len = max map { .chars }, %sequences.keys;
	my @sequences = map { sprintf("%-"~$len~"s %s", .key, .value) }, %sequences.sort({.value});

	# print and copy the output
	put @sequences.join("\n");
	#use Clipboard:from<Perl5>;
	#Clipboard.copy_to_all_selections(@sequences.join("\n"));
} else {
	print Q:c:to/END/;
	regular ({$regular.elems}) is not the same length as composed ({$composed.elems})
		regular:	{$regular}
		composed:	{$composed}
	END
}
