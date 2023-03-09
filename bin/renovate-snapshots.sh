#!/usr/bin/env bash

source ~/.nvm/nvm.sh

set -euo pipefail

REMOTE="origin"
BRANCH="$(git rev-parse --abbrev-ref HEAD)"
FORCE_CONTINUE="false"
PACKAGE_MANAGER="yarn"

while [[ $# -gt 0 ]]; do
  case $1 in
    --remote)
      REMOTE="$2"
      shift
      shift
      ;;
    --branch)
      BRANCH="$2"
      shift
      shift
      ;;
    --package-manager)
      PACKAGE_MANAGER="$2"
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
  esac
done

PACKAGE_MANAGER_COMMAND="$PACKAGE_MANAGER test -u"

function print_configuration {
  echo "Configuration:"
  echo "  Remote branch to reset to: '${REMOTE}/${BRANCH}'"
  echo "  Local branch to commit upgrades to: '$BRANCH'"
  echo "  Package manager: '$PACKAGE_MANAGER'"
  echo "  Package manager command: '$PACKAGE_MANAGER_COMMAND'"
}

function reset_to_remote {
  echo "Resetting local branch to remote..."

  nvm use # ensure we use the correct node version
  git checkout "$BRANCH"
  git pull "$REMOTE" "$BRANCH"
  git reset "${REMOTE}/${BRANCH}" --hard
  git pull "$REMOTE" "$BRANCH"

  echo "✅ Pulled and rest to remote branch"
}

function update_snapshots {
  echo "Updating snapshots..."

  nvm use # ensure we use the correct node version
  yarn # ensure we have the latest packages installed

  set +e
  $PACKAGE_MANAGER_COMMAND
  set -e

  echo "✅ Snapshots updated!"
}

function echo_diff_summary {
  echo ""
  echo "Updated snapshots:"
  git diff --name-status | cat
}

function main {
  reset_to_remote
  update_snapshots
  echo_diff_summary

  echo "✅ Snapshots updated!"
  echo "  You should now inspect the changes before committing and pushing"
}

print_configuration

if [[ $FORCE_CONTINUE = "true" ]]
then
  main
else
  echo "🚨🚨🚨 This will hard reset your local '$BRANCH' branch and you will lose any changes 🚨🚨🚨"
  read -r -p "Would you like to hard reset your local '$BRANCH' branch and update snapshots? [y/N] " response
  if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
  then
      main
  else
      exit 0
  fi
fi
