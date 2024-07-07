### Special setup
- homebrew - https://brew.sh/
- xcode cli tools - `xcode-select --install`
  - Check installed version: https://mac.install.guide/commandlinetools/2.html
  - Installation: https://mac.install.guide/commandlinetools/4.html
- nvm - https://github.com/nvm-sh/nvm#installing-and-updating
  - (must install after xcode cli & git)
- rvm
  - Install gnupg via homebrew first
  - Install rvm: https://rvm.io/rvm/install
  - If downloading public keys from the default keyserver fails, try other keyservers: https://rvm.io/rvm/security#install-our-keys
  - If downloading public keys from all the keyservers fail, download from them from the rvm webserver: https://rvm.io/rvm/security#alternatives
  - Retry the command for installing rvm

### Homebrew
- gnupg (gpg2) (replaces gpg in the cli)
- ag
- tldr
- zsh-syntax-highlighting

### Packages that come with xcode cli tools
- git
- gcc compiler (needed for Python)
- To view the whole list (https://mac.install.guide/commandlinetools/8.html):
```
ls /Library/Developer/CommandLineTools/usr/bin/
```

### Ruby

Ensure rvm has the latest ruby versions available:
```
rvm get master
rvm reload
rvm list known
```

Download ruby:
```
rvm install ruby --latest
```
The latest ruby version (3.3.2) installed successfully on an Apple M2 Mac, Sonoma 14.4.

Otherwise, if there's an error including `Error running '__rvm_make -j16'`, try using openssl@1.1 for the ruby install: https://github.com/rvm/rvm/issues/5404#issuecomment-1806701326

### Node
```
nvm install stable
```

### Python
Docs: https://docs.python-guide.org/starting/install3/osx/
```
brew install python
```
Add to the PATH in .zshrc:
```
export PATH="$PATH:/opt/homebrew/opt/python@3.12/libexec/bin"
```
