#!/usr/bin/env bash

alias git-nv="git -c core.hooksPath=/dev/null"

alias git-checkout-from-master="\
  git-nv fetch origin master && \
  git-nv checkout origin/master -b"

alias git-checkout-from-main="\
  git-nv fetch origin master && \
  git-nv checkout origin/master -b"


alias git-push-head="git-nv push origin HEAD"
