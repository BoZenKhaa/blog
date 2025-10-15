# Python venv

Create venv called "venv" in folder `./venv`:
```Bash
python -m venv ./venv
```

Activate environment
```Bash
source venv/bin/activate # in Bash
.\venv\Scripts\activate # on Windows PS
```

Update/add pip in active environment, e.g. with prompt with starting with `(venv)`
```Bash
python -m pip install --upgrade pip
```

Add packages to the environment with pip
```Bash
pip install package # download package and install
pip install -e ./my_local_repo/python # install local package for development, the final folder must include `setup.py`
```

## Pycharm
In Pycharm, go to Project -> Python interpreter -> Add Interpreter. 

There, select "Virtual Environment", check "Existing" and enter path to the environment, e.g. `~/venv/bin/python`. Done.

### Notes on RCI
On the RCI cluster, first `module load` the appropriate python to use. When developing remotely, this has to be done in `.bash_profile` which, unlike `.bashrc`, gets processed when JetBrains gateway ssh's into the server.
E.g., put this into `.bash_profile`:
```Bash
# Bash_profile is run when idea gateway connects to the server. The below makes python interpreter available to pycharm.
if [[ -n $SSH_CONNECTION ]] ; then
       echo "Running Module Load: Gurobi"
       ml Gurobi/10.0.0-GCCcore-11.3.0/
fi
```

## Multiple Python versions

### pyenv 
[pyenv for Windows ](https://github.com/pyenv-win/pyenv-win) is a tool for managing Python installations.

It lets you install multiple versions of Python and switch between them, either globally, or per folder. 

Commands:
```Bash
pyenv version # show current python version/folder it is related to

pyenv install -l # list all available python versions
pyenv install 3.8.10 # install python version    

pyenv global 3.8.10 # set python version globally
pyenv local 3.8.10 # set python version for current folder
```

### uv
[uv](https://docs.astral.sh/uv/getting-started/installation/) is a tool for managing Python versions.

Core to using uv is "project". Projejct in uv is similat to a project in Julia, and works with `project.toml` file. Project may contain python venv environment. 

Useful commands:
```Bash
# Managing python versions
uv venv --python 3.10 # create venv with python 3.10

# Managing project
uv init # initialize project
uv add package # add package to project, if there is venv, it will be added to it
uv add --editable ../projects/bar/ # add local package to project as editable


# Environment
source .venv/bin/activate # activate venv, same old way

```