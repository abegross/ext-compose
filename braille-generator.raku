say q:to/END/;
#
# BRAILLE for XCompose.
#
# This file has been automatically generated. Any edits may be lost if it gets
# generated again.
#
#
# The way to use braille is by following the unicode pattern of the braille: 
#
# 1 4
# 2 5
# 3 6
# 7 8
#
# So, the following character is written as ⎄B567␣. With B as the Braille seletor, and space to finalize the selection.
#
# ○ ○
# ○ ●
# ○ ●
# ● ○
#
END


say Q:b:to/END/;
#################################
##########   BRAILLE   ##########
#################################
END
say '<Multi_key> <B> <space> 					: "⠀" U2800	# BRAILLE PATTERN BLANK';
# add all the main braille characters.
my @dots;
for 0x2801..0x28FF {
	my $dots = .uniname.split('-')[1].split('', :skip-empty);
	@dots.push: [$dots.join, .chr];
}
say shell('raku ./compose-creator.raku --multiple ' ~
	'--regular="' ~ @dots.map({.[0]}) ~ '" ' ~
	'--composed="' ~ @dots.map({.[1]}) ~ '" ' ~
	'--sequence="⎄B★␣"', :out, cwd => $*PROGRAM.dirname).out.slurp;
