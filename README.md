ext-compose
=========

As explained in <http://canonical.org/~kragen/setting-up-keyboard.html>, your Compose key in X11 is controlled by (among other things) the file `.XCompose` in your home directory.  This file gives you a large set of bindings for Unicode characters that are useful.

ext-compose add nearly 15,000 (and counting) new bindings!

More contributions are welcome and encouraged! We're trying to come up with a broadly acceptable set of keybindings that won't interfere with the traditional Compose bindings, aren't too hard to type, and cover a wide set of characters that are useful to use occasionally, making them available without the need for specialized input methods.


Installation
------------

Use the `install` script to install all the compose sequences.

	 git clone https://github.com/grenzionky/ext-compose.git
	 cd ext-compose
	 ./install

You can add custom personal compose sequences at the of the `~/.XCompose` file.


	 include "/path/to/emoji.compose"
	 include "/path/to/modletters.compose"
	 include "/path/to/fancyletters.compose"
	 include "/path/to/hangul.compose"
	 include "/path/to/japanese.compose"

	 # I complain a lot, oy...
	 <Multi_key> <O> <Y>	: "ѹ" U0479	# CYRILLIC SMALL LETTER UK
	 # My very original smileyface!
	 <Multi_key> <parenleft> <t> <u> <parenright> : "㋡" U32E1 # CIRCLED KATAKANA TU
	 # ...
