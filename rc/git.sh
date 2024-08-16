#!/usr/bin/env bash

alias git-checkout-from-master="\
  git -c core.hooksPath=/dev/null fetch origin master && \
  git -c core.hooksPath=/dev/null checkout origin/master -b"

alias git-checkout-from-main="\
  git -c core.hooksPath=/dev/null fetch origin master && \
  git -c core.hooksPath=/dev/null checkout origin/master -b"

alias git-nv="git -c core.hooksPath=/dev/null"
