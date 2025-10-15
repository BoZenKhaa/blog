# SLAMuZero

Installing: https://github.com/bwfbowen/SLAMuZero?tab=readme-ov-file
Requires installing https://github.com/bwfbowen/acme-more-mcts

Notes and issue fixes:

1. Not sure which Python version this is meant for, probably Python 3.8?
2. Reverb currently only supports Linux based OSes. - https://pypi.org/project/dm-reverb/
3. Older jaxlib wheel requires manual insallation, https://docs.jax.dev/en/latest/installation.html:
`pip install jaxlib==0.4.3 -f https://storage.googleapis.com/jax-releases/jax_releases.html`
4. Sometimes, import results in `ImportError: libpython3.9.so.1.0: cannot open shared object file: No such file or directory`. Possible fix is setting `LD_LIBRARY_PATH` to the location of the `libpython3.9.so.1.0` file, e.g. ` export LD_LIBRARY_PATH=/home/mrkosja1/bin/anaconda3/envs/habitat/lib`
5. 




### 1st Process on aic-ml (Ubuntu 18.04):
1. `mkdir SLAMuZero`, `cd SLAMuZero`
2. `pyenv install 3.9` - fix issues as they come up with [help](https://github.com/pyenv/pyenv/wiki/Common-build-problems#error-the-python-ssl-extension-was-not-compiled-missing-the-openssl-lib)
    - libssl-dev - helped by this [post](https://superuser.com/questions/1417691/libssl-dev-dependency-issue-on-ubuntu-18-04)
    - `sudo apt install zlib1g zlib1g-dev libssl-dev libbz2-dev libsqlite3-dev`
    - WARNING: The Python lzma extension was not compiled. Missing the lzma lib? - resolved with `sudo apt install liblzma-dev`
    - Fails to install ` libxml2-dev` and `libxmlsec1-dev`, the error is 
    ```
    The following packages have unmet dependencies:
    libxml2-dev : Depends: libicu-dev but it is not going to be installed
    libxmlsec1-dev : Depends: libgnutls28-dev but it is not going to be installed
    E: Unable to correct problems, you have held broken packages.
    ```
3. Setup pyenv
    - `pyenv local 3.9` - set python version for current folder to 3.9
4. Setup venv
    - `python -m venv ./venv` - create venv called "venv" in folder `./venv`
    - `source venv/bin/activate` - activate environment

Result: multiple irresolvable dependencies




### 2nd Process on aic-ml (Ubuntu 18.04) - using anaconda:

1. Download (anaconda)[https://www.anaconda.com/docs/getting-started/anaconda/install#macos-linux-installation]
2. Activate conda:
    - `conda init zsh` - add conda to bash profile
    - `source ~/.zshrc` - reload bash profile
3. Create conda environment:
    - `conda create --name slam python=3.9` - create conda environment called "slam" with python 3.9
    - `conda activate slam` - activate environment
5. Download packages:
    - `git clone git@github.com:BoZenKhaa/acme-more-mcts.git`
    - `git clone git@github.com:BoZenKhaa/SLAMuZero.git`
6. Start installing `acme-more-mcts`
 - cd into `acme-more-mcts` and run:
   - `pip install ".[jax,tf,testing,envs]"`
   - Install older jaxlib version: `pip install jaxlib==0.4.3 -f https://storage.googleapis.com/jax-releases/jax_releases.html`
   - Continue install with `pip install ".[jax,tf,testing,envs]"`
7. Install `habitat-api` and `habitat-sim`
   - 

Result: issues between conda and pip

### 3rd environment on aic-ml with conda - try to install all packages via conda:

1. set up environment:
```Bash
conda create --name slam2 python=3.9
conda activate slam2
```
2. Start by installing `acme-more-mcts` dependencies manually first from conda. 
Use `conda search` to find the package name.

- Tensorflow: install via reverb
- Reverb - install via pip only
- Jax - `conda install jax=0.4.16` - .16 forced by flax
 - dm-haiku - not in conda, apparently superseded by flax?
 - flax - `conda install conda-forge::flax` 
 - other jax dependencies are pip only as well
 
3. Install habitat stuff via conda

From https://github.com/facebookresearch/habitat-sim
```Bash
conda install habitat-sim withbullet headless -c conda-forge -c aihabitat 
```
Then habitat-lab needs to be installed via pip.

4. Pip installs
 - reverb and tf: `pip install "dm-reverb[tensorflow]==0.7"` - dropping minor version specifier, e.g. `0.7.0` to `0.7.*`
 - Edit setup.py in acme-more-mcts and try install: `pip install ".[jax,tf,testing,envs]"` 
 - Installl habitat-lan:
 ```Bash
 cd habitat-lab
 pip install -e habitat-lab
 pip install -e habitat-baselines
 ```
5. Fixes after trying to run `python run_acme.py`:
- `export LD_LIBRARY_PATH=/home/mrkosja1/bin/anaconda3/envs/slam2/lib` 
- `export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/ollama` - to address " Could not load dynamic library 'libcudart.so.11.0'" error, path found with `sudo find / -name 'libcudart.so.11.0'   `
- `pip install seaborn scikit-fmm torch yacs gymnasium torchvision scikit-learn`

Issue: 
`ImportError: This version of TensorFlow Probability requires TensorFlow version >= 2.18; Detected an installation of version 2.8.4. Please upgrade TensorFlow to proceed.`
Fix:
`pip install tensorflow-probability==0.16.0` - based on [release notes](https://github.com/tensorflow/probability/releases/tag/v0.16.0)

6. Download dataset:
 - fill a licence agreement, that results in following links:

## Gibson Database of 3D Spaces
Thanks for checking out our dataset. Be sure to visit iGibson website(http://svl.stanford.edu/igibson/) and documentation(http://svl.stanford.edu/igibson/docs/) for new features.

You can download the dataset using the following links:


A. To use with Gibson Env (CVPR 2018) 

=========================================
Gibson Env V1 data

>"Tiny" Partition (8.02 GB):
https://storage.googleapis.com/gibson_scenes/gibson_tiny.tar.gz
>"Medium" Partition (20.8 GB):
https://storage.googleapis.com/gibson_scenes/gibson_medium.tar.gz
>"Full" Partition (64.96 GB):
https://storage.googleapis.com/gibson_scenes/gibson_full.tar.gz 
>"Full+" Partition (23.91 GB):
https://storage.googleapis.com/gibson_scenes/gibson_fullplus.tar.gz  
=========================================
>Stanford 2D-3D-Semantics, Armeni et al. 2017 (3.9 GB):
https://storage.googleapis.com/gibson_scenes/2d3ds_for_gibson.tar.gz
=========================================


B. To use with iGibson (2020)

==========================================
> Gibson dataset for sim2real challenge 2020
 https://storage.cloud.google.com/gibsonchallenge/gibson-challenge-data.tar.gz

> Gibson dataset for iGibson / Gibson V2 / Interactive Gibson Environment

All scenes, 572 scenes (108 GB):
https://storage.googleapis.com/gibson_scenes/gibson_v2_all.tar.gz

4+ partition, 106 Scenes, with textures better packed (2.6GB):
https://storage.googleapis.com/gibson_scenes/gibson_v2_4+.tar.gz

Interactive Gibson dataset, 10 scenes, with replaced objects and textures:
https://storage.googleapis.com/gibson_scenes/interactive_dataset.tar.gz

(new) 2D3DS for iGibson, 7 scenes (1.4GB)
https://storage.googleapis.com/gibsonchallenge/2d3ds_for_igibson.zip

(new) iGibson dataset, 15 scenes, fully interactive! (signing GDS not required) 
Link to download iGibson dataset: https://storage.googleapis.com/gibson_scenes/ig_dataset.tar.gz

=========================================


C. To use with Habitat-sim (ICCV 2019)

=========================================
> Gibson Dataset (trainval) for use with Habitat (11 GB):
All training and validation scenes of the Gibson dataset for use with Habitat Sim: 
https://dl.fbaipublicfiles.com/habitat/data/scene_datasets/gibson_habitat_trainval.zip
General information/instructions about Habitat is available at https://aihabitat.org/ and https://github.com/facebookresearch/habitat-sim .

> Gibson Dataset for Habitat challenge (1.5 GB):
Habitat challenge uses a smaller subset of 4+ quality scenes (as described in the Habitat ICCV19 paper https://arxiv.org/abs/1904.01201). Available here: 
https://dl.fbaipublicfiles.com/habitat/data/scene_datasets/gibson_habitat.zip


=========================================
Further information and instructions available at
https://github.com/StanfordVL/GibsonEnv/blob/master/gibson/data/README.md and http://gibsonenv.stanford.edu/database/. 