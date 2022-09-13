### Searching

# Case-insensitive, recursive search for text in files.
rg -i <string>
ag -i <string>
grep -i -IR <string> .

# Case-insensitive, recursive search for file names.
ag -g <string>
find . -name <pattern>

# Grep and exclude pattern
grep -v <string>


### Rails

# Find ruby gem version.
bundle show <gem>


### JS

yarn list --pattern <pattern> # Find npm package vesrion.
yarn why <package>            # Find why a version(s) of a package is included in yarn.lock.
yarn info <package>           # Fetch info about a package, including latest stable version.


### Misc.

# File permissions
ls -l | grep temp.txt # Show file permissions for a file
chmod 777 temp.txt    # Give current user full access to the file

# Kill a process
ps | grep -i <search> # List running processes.
lsof -i ':<port>'     # List what's listening on a port.

kill -9 <pid>         # Kill the process.

# scp
scp remote_host:path/to/remote_file path/to/local_directory

# xcode-select - manage the active developer directory
xcode-select -p              # print the path of the active developer directory
xcode-select --switch <path>  # set the path for the active developer directory

# Switching paths resolved the error:
# Failed to locate 'git', requesting installation of command line developer tools.

# Likely paths for xcode-select:
# /Applications/Xcode.app/Contents/Developer
# /Library/Developer/CommandLineTools
