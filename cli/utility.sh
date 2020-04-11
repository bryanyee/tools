### Searching
# Case-insensitive, recursive search for text in files.
rg -i <string>
ag -i <string>
grep -i -IR <string> .

# Case-insensitive, recursive search for file names.
ag -g <string>
find . -name <pattern>
