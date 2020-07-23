# add the hangul filler/space and tone marks
say shell('raku ./compose-sequence-generator.raku --multiple ' ~
	'--regular="␣" --composed="ㅤ" --sequence="⎄J★"', 
	:out, cwd => $*PROGRAM.dirname).out.slurp;
