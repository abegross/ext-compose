all: base.compose diacritics.compose emoji.compose fancyletters.compose hangul.compose hebrew.compose japanese.compose modletters.compose

%.compose: %-base emojitrans2.pl
	./emojitrans2.pl < $< > $@
