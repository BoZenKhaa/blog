# You received new account on a Linux server....

1. Set up ssh key with ssh-agent (`ssh-add .ssh/id_newkey`) and configure it in .ssh/config file.
2. Log into the server with `mc` and copy over relevant parts of home
    - `.config/mc`
    - install [oh-my-zsh](https://ohmyz.sh/#install) and copy over:
        - `.zshrc` - check for differences with `vimdiff .zshrc .zshrc.pre-oh-my-zsh`
        - `.oh-my-zsh/custom` - files with customisations, e.g. `aliases.zsh`
        - in `.zshrc`, check for plugins. If you are setting up on a server, having `ssh-agent` WILL MASK forwarding agent from local machine, so remove it. 
     