say q:to/END/;
#
# HANGUL for XCompose.
#
# This file has been automatically generated. Any edits may be lost if it gets
# generated again.
#
#
# The romaja (로마자) here is the same as what unicode uses (because it was the
# simplest to implement. I can change it if enough people want).
#
# ｢J｣ is the selector for hangeul cuz H (hangeul) and K (korean)
# are taken by Hiragana and Katakana, so the hint here is ｢J｣oseon (조선/朝鮮).
#
#
# An extra space may be required at the end of radicals to avoid conflicts. 
# (think of it as a way to "lock in" your compose sequence)
#
# Ex: 가 is "ga␣" so that you can type 각, which is gag␣ so that you can type gagg for 갂.
#
# The rule of thumb (of when to add a space) is to just type out the character you want, 
# and if nothing happens, add a space.
#
#
#
# =RADICALS=
#
# Gotchas:
# ᅙ is "?" cuz its a glottal stop, and ? looks like ʔ which is the glottal stop in IPA.
# ᄓ is "nk" because "ng" is taken from ᅌ.
#
#
# -REGULAR RADICALS-
#
# The subselector for radicals is ｢J｣ because 
# ① your hand is already there, so its easy to just press it again. 
# ② ｢J｣ungseong and ｢J｣ongseong
#
# Ex: ㅀ is ⎄JJrh
# Ex: ㅇ is ⎄JJ␣ (cuz ㅇ looks like "o")
# Ex: ㅱ is ⎄JJmo
# Ex: ㅭ is ⎄JJr?
# Ex: ㆁ is ⎄JJng␣ (the extra space is to not conflict with the next example)
# Ex: ㆃ is ⎄JJngz
#
# -COMBINABLE RADICALS-
#
# The subselector for choseong radicals is ｢I｣nitial.
# The subselector for jongseong  radicals is ｢V｣owel.
# The subselector for jungseong  radicals is ｢F｣inal.
#
# Ex: ᄚ is ⎄JIrh
# Ex: ᆪ   is ⎄JFgs␣
# Ex: ᇄ   is ⎄JFgsg
#
# =HALFWIDTH=
#
# The subselector for halfwidth hangul is ｢H｣ cuz ｢H｣alfwidth.
#
# Ex: ﾻ is ⎄JHk
#
# =SURROUNDED=
#
# -CIRCLED-
#
# Ex: ㉼ is ⎄J(camgo)
#
# -PARANTHESIZED-
#
# The space is there just so that it makes a parenthesized version, and not a full circle.
#
# Ex: ㈞ is ⎄J( ohu)
#

END


sub make-hangul($codepoints, Str $sequence, @regular-list) {
	my @regular = @regular-list.map: -> $v { @regular-list.grep(/^$v.+/) ?? $v ~ "␣" !! $v };
	my @hangul = $codepoints.map: {[@regular[$++], .chr]};

	return shell('raku ./compose-sequence-generator.raku --multiple ' ~
			qq{--regular="@hangul.map({.[0]})" --composed="@hangul.map({.[1]})" } ~ 
			qq{--sequence="⎄J$sequence"}, :out, cwd => $*PROGRAM.dirname).out.slurp;
}


# add the hangul filler/space and tone marks
say shell('raku ./compose-sequence-generator.raku --multiple ' ~
	'--regular="␣" --composed="ㅤ" --sequence="⎄J★"', 
	:out, cwd => $*PROGRAM.dirname).out.slurp;

say Q:b:to/END/;
#################################
##### PRECOMPOSED SYLLABLES #####
#################################
END
# add all the hangul precomposed syllables.
my @hangul;
for 0xAC00..0xD7A3 {
	my $name = .uniname.words[2];
	my $badcim = $name.split(/<[AEIOU]>/)[*-1];
	# dont add a space to badcim if its <[CDHJKMPT]> cuz it cant conflict
	#say $badcim ~ ".";
	$name ~= '␣' if $badcim.chars < 2 and $badcim !~~ /<[CDHJKMPT]>/;
	@hangul.push: [$name.lc, .chr];
}
say shell('raku ./compose-sequence-generator.raku --multiple ' ~
	'--regular="' ~ @hangul.map({.[0]}) ~ '" ' ~
	'--composed="' ~ @hangul.map({.[1]}) ~ '" ' ~
	'--sequence="⎄J★"', :out, cwd => $*PROGRAM.dirname).out.slurp;




say Q:b:to/END/;
\n
################################
########### RADICALS ###########
################################
\n\n\n# RADICALS
END

my @radicals = <g gg gs n nj nh d dd r rg rm rb rs rt rp rh m b bb bs s ss ␣ j jj c k t p h a ae ya yae eo e yeo ye o wa wae oe yo u weo we wi yu eu yi i nn nd ns nz rgs rd rbs rz r? mb ms mz mo bg bd bsg bsd bj bt bo bbo sg sn sd sb sj z oo ng ngs ngz po hh ? yoya yoae yoi yeyeo yuye yui . .i>;
say make-hangul((|(0x3131..0x3163),|(0x3165..0x318E)), "J★", @radicals);


say Q:b:to/END/;
\n
###############################
##### COMBINABLE RADICALS #####
###############################
\n# COMBINABLE RADICALS
\n# The selector for choseong radicals is ｢I｣nitial.
END

# choseong
# the ᅙ is "?" cuz its a glottal stop, and ? looks like ʔ which is the glottal stop in IPA.
my @choseong = <g gg n d dd r m b bb s ss o j jj c k t p h nk nn nd nb dg rn rr rh ro mb mo bg bn bd bs bsg bsd bsb bss bsj bj bc bt bp bo bbo sg sn sd sr sm sb sbg sss so sj sc sk st sp sh 1s 1ss 2s 2ss z og od om ob os oz oo oj oc ot op ng jo 1j 1jj 2j 2jj ck ch 1c 2c pb po hh ? gd ns nj nh dr ␣   dm db ds dj rg rgg rd rdd rm rb rbb rbo rs rj rk rg rd rs bst bk bh ssb ol oh jjh tt ph hs ??>;
say make-hangul((|(0x1100..0x115F),|(0xA960..0xA97C)), "I★", @choseong);

# jongseong
say Q:b:to/END/;
\n# The selector for jongseong radicals is ｢V｣owel.
END
my @jongseong-range = (|(0x1160..0x11A7),|(0xD7B0..0xD7C6));
my @jongseong = @jongseong-range.map: {
	.uniname.words[*-1].subst("SSANGARAEA","..").subst("ARAEA",".")
	.subst("-","",:g).subst("FILLER","␣").lc
};
say make-hangul(@jongseong-range, "V★", @jongseong);

# jungseong
say Q:b:to/END/;
\n# The selector for jungseong radicals is ｢F｣inal.
END
my @jungseong = <g gg gs n nj nh d l lg lm lb ls lt lp lh m b bs s ss o j c k t p h gl gsg nk nd ns nz nt dg dl lgs ln ld ldh ll lmg lms lbs lbh lbo lss lz lk l? mg ml mb ms mss mz mc mh mo bl bp bh bo sg sd sl sb z ngg nggg ngng ngk ng ngs ngz pb po hn hl hm hb ? gn gb gc gk gh nn nl nc dd ddb db ds dsg dj dc dt lgg lgh llk lmh lbd lbp lng l?h lo mn mnn mm mbs mj bd blp bm bb bsd bj because sm sbo ssg ssd sz sj sc st sh zb zbo ngm ngh jb jbb jj ps pt>;
say make-hangul((|(0x11A8..0x11FF),|(0xD7CB..0xD7FB)), "F★", @jungseong);


say Q:b:to/END/;
\n
###############################
########## HALFWIDTH ##########
###############################
\n# COMBINABLE RADICALS
\n# The selector for halfwidth radicals is ｢H｣afwidth.
END
say make-hangul((0xFFA0..0xFFDC).grep({$_ unless .uniprop eq "Cn"}), "H★",
<␣ g gg gs n nj nh d dd r rg rm rd rs rt rp rh m b bb bs s ss ng j jj c k t p h a ae ya yae eo e yeo ye o wa wae oe yo u weo we wi yu eu yi i>
);


say Q:b:to/END/;
\n
###############################
########### CIRCLED ###########
###############################
\n# CIRCLED HANGUL
END
say make-hangul((0x3260..0x327E), "(★)",
	<g n d r m b s ng j c k t p h ga na da ra ma ba sa a ja ca ka ta pa ha camgo juyi u>
);

# Parenthesized
say Q:b:to/END/;
\n# PARENTHESIZED HANGUL
\n# The space is there just so that it makes a parenthesized version, and not a full circle.
END
say make-hangul((0x3200..0x321E), "( ★)",
	<g n d r m b s ng j c k t p h ga na da ra ma ba sa a ja ca ka ta pa ha ju ojeon ohu>
);


say Q:b:to/END/;
\n\n
#MISCELLANEOUS\n
<Multi_key> <J> <space> 		: "ㅤ" U3164	# HANGUL FILLER
<Multi_key> <J> <period> 		: U302E	# HANGUL SINGLE DOT TONE MARK
<Multi_key> <J> <2> <period> 	: U302F	# HANGUL DOUBLE DOT TONE MARK
END
