#!/bin/bash

source ~/scripts/rc/checksum.sh
source ~/scripts/rc/reload.sh
source ~/scripts/rc/portkill.sh
source ~/scripts/rc/base64.sh

alias bump-packages="/Users/tings/scripts/bin/bump-packages.sh"
alias update-snapshots="/Users/tings/scripts/bin/update-snapshots.sh"
alias renovate-snapshots="/Users/tings/scripts/bin/renovate-snapshots.sh"
alias git="git -c core.hooksPath=/dev/null"
