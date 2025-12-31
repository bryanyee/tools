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

### Setup python environment in a new repo with pyenv and venv
```
# In the new repo
pyenv install 3.11.8
pyenv local 3.11.8 # Select the python version to use in repo
python -m venv .venv # Create a virtual environment
source .venv/bin/activate # Activate the virtual environment
pip install flask # Install initial packages
pip freeze > requirements.txt # Save dependencies to requirements.txt
```

### Use venv to manage the project
Run the following when re-entering a directory with python already set up:
```
source .venv/bin/activate # Activate the virtual environment
pip install -r requirements.txt # Installs the latest updates from requirements.txt
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
Run the flask app (with venv activated):
```
flask run
```
