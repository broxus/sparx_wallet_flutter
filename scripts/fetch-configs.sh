#!/bin/bash

# Fetch the JSON and save it to /assets/configs/connections.json
curl -sSL "https://raw.githubusercontent.com/broxus/sparx-networks/master/connections_prod_v2.json" -o "$(dirname "$0")/../assets/configs/connections_v2.json"

# Fetch the JSON and save it to /assets/configs/update_rules.json
curl -sSL "https://raw.githubusercontent.com/broxus/sparx-networks/master/update_rules_prod.json" -o "$(dirname "$0")/../assets/configs/update_rules.json"

# Fetch the JSON and save it to /assets/configs/release_notes.json
curl -sSL "https://raw.githubusercontent.com/broxus/sparx-networks/master/release_notes_prod.json" -o "$(dirname "$0")/../assets/configs/release_notes.json"