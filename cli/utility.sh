### Searching

# Case-insensitive, recursive search for text in files.
rg -i <string>
ag -i <string>
grep -i -IR <string> .

# Case-insensitive, recursive search for file names.
ag -g <string>
find . -name <pattern>


### Rails

# Find ruby gem version.
bundle show <gem>


### JS

yarn list --pattern <pattern> # Find npm package vesrion.
yarn why <package>            # Find why a version(s) of a package is included in yarn.lock.
yarn info <package>           # Fetch info about a package, including latest stable version.

### Misc.

# Kill a process
ps | grep -i <search> # List running processes.
lsof -i ':<port>'     # List what's listening on a port.

kill -9 <pid>         # Kill the process.
