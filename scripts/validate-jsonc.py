#!/usr/bin/env python3
"""Validate a JSONC file (JSON with comments + trailing commas)."""
import json, re, sys

with open(sys.argv[1]) as f:
    text = f.read()

# strip block comments
text = re.sub(r'/\*.*?\*/', '', text, flags=re.DOTALL)

# strip line comments (only outside strings)
lines = []
in_str = False
for line in text.split('\n'):
    out = []
    i = 0
    while i < len(line):
        c = line[i]
        if c == '"' and (i == 0 or line[i-1] != '\\'):
            in_str = not in_str
        if not in_str and c == '/' and i+1 < len(line) and line[i+1] == '/':
            break
        out.append(c)
        i += 1
    lines.append(''.join(out))
text = '\n'.join(lines)

# trailing commas
text = re.sub(r',\s*([}\]])', r'\1', text)

json.loads(text)
print(f'{sys.argv[1]}: OK')