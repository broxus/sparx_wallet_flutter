#!/bin/bash

# Fetch the JSON and save it to /assets/configs/connections.json
curl -sSL "https://raw.githubusercontent.com/broxus/sparx-networks/master/connections_prod.json" -o "$(dirname "$0")/../assets/configs/connections.json"