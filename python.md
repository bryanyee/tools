## Set up Python

### Set up pyenv
Install pyenv (see latest instructions at https://github.com/pyenv/pyenv):
```
brew install pyenv
```
Add the following to ~/.zshrc:
```
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
```
Restart shell:
```
exec "$SHELL"
```
Install Python dependencies:
- See https://github.com/pyenv/pyenv/wiki#suggested-build-environment

### Install python
```
pyenv install 3.11.8
```

### Prepare project directory and set up pipenv
Move into the project directory for a Python project:
```
mkdir <project>
cd <project>
```
Select the python version to use in the local directory:
```
pyenv local 3.11.8
```
Install pipenv:
```
pip install pipenv
```
Set pipenv to use the current python version from pyenv:
```
pipenv --python $(which python)
```

### Set up Pipfile and the virtual environment 
The first run of the install command creates Pipfile & Pipfile.lock, and start a new virtual environment for the project:
```
pipenv install
```
Install desired packages:
```
pipenv install flask
```

### Use pipenv to manage the project
Install packages specified in Pipfile.lock (such as after pulling the latest changes from version control):
```
pipenv sync
```
Activate the virtualenv for the current project directory:
```
pipenv shell
```
Run a command in the virtualenv:
```
pipenv run <command>
```
Show the path of the virtual environment:
```
pipenv --venv
```
Remove the virtual environment of the current project directory:
```
pipenv --rm
```

### Start a flask app
Create a file called `app.py`, and add the following to it:
```
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"
```
Run the flask app:
```
pipenv run flask run
```
