#!/bin/bash
if [[ -z "$WAMP_SECRET" ]]; then
  echo "no WAMP_SECRET environment variable was provided! exiting..."
  exit 1
fi
if [[ ! -f .crossbar/config.json.template ]]; then
  echo "no config.json.template found! exiting..."
  exit 2
fi

envsubst < .crossbar/config.json.template > .crossbar/config.json

crossbar start --cbdir .crossbar --loglevel info &
P1=$!
python ./exporter.py &
P2=$!
wait $P1 $P2