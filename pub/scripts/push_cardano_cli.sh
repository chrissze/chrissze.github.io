#!/bin/bash



# echo O2

# rsync -av -e 'ssh -p 55555' --progress ~/github/cardano/cardano-cli cs@O2:~/.local/bin

# rsync -av -e 'ssh -p 55555' --progress ~/github/cardano/cardano-node cs@O2:~/.local/bin

# rsync -av -e 'ssh -p 55555' --progress ~/github/cardano/cardano-cli almalinux@O2:~/.local/bin

# rsync -av -e 'ssh -p 55555' --progress ~/github/cardano/cardano-node almalinux@O2:~/.local/bin



echo fuji

rsync -av -e 'ssh -p 55555' --progress ~/github/cardano/cardano-cli cs@fuji:~/.local/bin

rsync -av -e 'ssh -p 55555' --progress ~/github/cardano/cardano-node cs@fuji:~/.local/bin
