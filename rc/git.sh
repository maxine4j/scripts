#!/usr/bin/env bash

alias git-checkout-from-master="\
  git -c core.hooksPath=/dev/null checkout master && \
  git -c core.hooksPath=/dev/null pull origin master && \
  git -c core.hooksPath=/dev/null checkout -b"

alias git-checkout-from-main="\
  git -c core.hooksPath=/dev/null checkout master && \
  git -c core.hooksPath=/dev/null pull origin master && \
  git -c core.hooksPath=/dev/null checkout -b"

alias git-nv="git -c core.hooksPath=/dev/null"
