#!/usr/bin/env python
import unicodedata2, re, pyperclip, sys, ast

def isevaluable(s):
    try:
        ast.literal_eval(s)
        return True
    except ValueError:
        return False

# usage: compose-sequence-generator.py 'regular' 'composed' 'sequence'
# 'regular', 'composed', and 'sequence' are defined below.

# the regular abcs or wtvr that will be typed out
# each letter in 'regular' corresponds to the respective letter in 'composed'
# regular = "0123456789"
regular = ["0123456789"] if not sys.argv[1] else \
         (eval(sys.argv[1]) if isevaluable(sys.argv[1]) else sys.argv[1])

# the characters that compose spits out
# composed = "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡"
composed = "𝟘𝟙𝟚𝟛𝟜𝟝𝟞𝟟𝟠𝟡" if not sys.argv[2] else sys.argv[2]

# the sequence u type out.
# "<M_>" means the compose key.
# <MM> means compose key twice
# ★ is what will be replaced with whats in regular
# sequence = "<M_> ★|"
sequence = "<M_> ★k" if not sys.argv[3] else sys.argv[3]



specials = {'%' : 'percent',
            '-' : 'minus',
            '_' : 'underscore',
            '>' : 'greater',
            '<' : 'less',
            ',' : 'comma',
            '.' : 'period',
            '$' : 'dollar',
            '!' : 'exclam',
            '?' : 'question',
            '+' : 'plus',
            '/' : 'slash',
            '#' : 'numbersign',
            '@' : 'at',
            '|' : 'bar',
            '`' : 'grave',
            '~' : 'asciitilde',
            '^' : 'asciicircum',
            '(' : 'parenleft',
            ')' : 'parenright',
            '[' : 'bracketleft',
            ']' : 'bracketright',
            '{' : 'braceleft',
            '}' : 'braceright',
            "'" : 'apostrophe',
            '"' : 'quotedbl',
            '\\': 'backslash',
            ':' : 'colon',
            ';' : 'semicolon',
            '=' : 'equal',
            ' ' : 'space',
            '*' : 'asterisk',
}

def replace(sequence):
    sequence = "".join([f'<{specials.get(letter, letter)}> ' for letter in sequence])
    sequence = re.sub(r"^<less> <M> <underscore> <greater> <space>", "<Multi_key>", sequence)
    sequence = re.sub(r"^<less> <M> <M> <greater> <space>", "<Multi_key> <Multi_key>", sequence)
    return sequence

sequence = replace(sequence)

if len(regular) == len(composed):
    text = ""
    sequences=[[],[]]
    length=0
    for position in range(len(regular)):
        current_sequence = sequence.replace("<★>", replace(regular[position])).strip()
        if len(current_sequence) > length:
            length = len(current_sequence)
        sequences.append(current_sequence)
        sequences.append('\t\t:\t"'+composed[position]+'"\t'+str('U%04X' % ord(composed[position])) +'\t# '+ unicodedata2.name(composed[position]))#+'\n')
        # add extra tabs if the finished compose sequence is too short (so that it lines up right)
    
    col_width = max(len(word) for row in sequences for word in row) + 2  # padding
    for row in sequences:
        print("".join(word.ljust(col_width) for word in row))



    # Print each row using the computed format
    # for row in sequences:
      # print(row+"|")



    print(text.strip())
    pyperclip.copy(text)
else:
    print("regular ("+ str(len(regular))+ ") is not equal to composed ("+str(len(composed))+ ")")

