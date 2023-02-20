#!/usr/bin/env bash

source ~/.nvm/nvm.sh

set -euo pipefail

MAIN_BRANCH_NAME="master"
UPSTREAM_REMOTE="origin"
CURRENT_BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"
PACKAGES=""
FORCE_CONTINUE="false"

while [[ $# -gt 0 ]]; do
  case $1 in
    --main-branch)
      MAIN_BRANCH_NAME="$2"
      shift
      shift
      ;;
    --upstream-remote)
      UPSTREAM_REMOTE="$2"
      shift
      shift
      ;;
    --current-branch)
      CURRENT_BRANCH_NAME="$2"
      shift
      shift
      ;;
    -y)
      FORCE_CONTINUE="true"
      shift
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      PACKAGES="$PACKAGES $1"
      shift
      ;;
  esac
done

function print_configuration {
  echo "Configuration:"
  echo "  Remote branch to reset to: '${UPSTREAM_REMOTE}/${MAIN_BRANCH_NAME}'"
  echo "  Local branch to commit upgrades to: '$CURRENT_BRANCH_NAME'"
  echo "  Packages upgrades: '$PACKAGES'"
}

function reset_to_main {
  nvm use # ensure we use the correct node version
  git checkout "$MAIN_BRANCH_NAME"
  git pull "$UPSTREAM_REMOTE" "$MAIN_BRANCH_NAME"
  git checkout "$CURRENT_BRANCH_NAME"
  git reset "${UPSTREAM_REMOTE}/${MAIN_BRANCH_NAME}" --hard
}

function upgrade_packages {
  nvm use # ensure we use the correct node version
  yarn # ensure we have the latest packages installed
  yarn upgrade $PACKAGES # upgrade the packages
  yarn # ensure we have a minimal lockfile
}

function main {
  reset_to_main
  upgrade_packages

  echo "✅ Packages upgraded!"
  echo "  You should now inspect the changes before committing and force pushing the branch"
  echo "  You may also need to update snapshots via 'yarn test -u' or similiar"
}

print_configuration

if [[ $FORCE_CONTINUE = "true" ]]
then
  main
else
  echo "🚨🚨🚨 This will hard reset your local branch and you will lose any changes 🚨🚨🚨"
  read -r -p "Would you like to hard reset the current branch and upgrade the above packages? [y/N] " response
  if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
  then
      main
  else
      exit 0
  fi
fi
