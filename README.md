ext-compose
=========

As explained in <http://canonical.org/~kragen/setting-up-keyboard.html>, your Compose key in X11 is controlled by (among other things) the file `.XCompose` in your home directory.  This file gives you a large set of bindings for Unicode characters that are useful.

ext-compose add nearly 15,000 (and counting) new bindings!

More contributions are welcome and encouraged! We're trying to come up with a broadly acceptable set of keybindings that won't interfere with the traditional Compose bindings, aren't too hard to type, and cover a wide set of characters that are useful to use occasionally, making them available without the need for specialized input methods.

This extension adds to the default compose sequences: Emojis, Latin variants (serif, italics, double-struck, superscript, subscript, small caps, cursive, fraktur, circled, squared, parenthesized, etc), Hebrew/Yiddish, Palmyrene, Japanese (Hiragana, Katakana, and some other characters), Korean Hangul (precomposed and jamo). Tons of mathematical, cultural, musical, typographical, IPA, and many *many* more symbols.


Installation
------------


Use the `install` script to install all the compose sequences.

	 git clone https://github.com/grenzionky/ext-compose.git
	 cd ext-compose
	 ./install

You can add custom personal compose sequences at the of the `~/.XCompose` file (or you can send it in here so that everyone can enjoy using it).

	include "%L"
	⋮
	include "/path/to/diacritics.compose"
	
	# I complain a lot, oy...
	<Multi_key> <O> <Y>	: "ѹ" U0479	# CYRILLIC SMALL LETTER UK
	# My very original smileyface!
	<Multi_key> <parenleft> <t> <u> <parenright> : "㋡" U32E1 # CIRCLED KATAKANA TU
	# ...


Scripts
-------

ext-compose comes bundles with many compose related scripts.
