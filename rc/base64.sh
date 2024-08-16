#!/usr/bin/env bash

function b64d {
  echo -n '$1' | base64 -d
}

function b64e {
  echo -n $1 | base64
}

