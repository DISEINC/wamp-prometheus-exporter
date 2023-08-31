#!/bin/bash
if [[ -f .crossbar/config.json.template ]]; then
  envsubst < .crossbar/config.json.template > .crossbar/config.json
else
  echo "no config.json.template found! exiting..."
  exit 1
fi

export WAMP_URL=ws://127.0.0.1:$WAMP_PORT

crossbar start --cbdir .crossbar --loglevel info &
P1=$!
python ./exporter.py &
P2=$!
wait $P1 $P2