#!/usr/bin/env bash

function ps-port {
  PORT=$1
  PID=$(sudo lsof -i -P | grep LISTEN | grep $PORT | awk '{ print $2 }')
  echo $PID
}

function kill-port {
  PORT=$1
  PID=$(ps-port $PORT)

  sudo kill -9 $PID
}

