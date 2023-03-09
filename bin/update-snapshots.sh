#/usr/bin/env

source ~/.nvm/nvm.sh

set -euo pipefail

nvm use
yarn
yarn test -u
