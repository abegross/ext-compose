my $chars = "가\x[302E]\x[302F]";
#$chars = $chars.split(" ").join;
say $chars».uninames.raku;

my $tones = "\x[302E]\x[302F]";
say shell('raku ./compose-sequence-generator.raku --multiple ' ~
	'--regular="␣ . 2." --composed="ㅤ'~$tones.NFC~'" --sequence="⎄J★"', 
	:out, cwd => $*PROGRAM.dirname).out.slurp;
