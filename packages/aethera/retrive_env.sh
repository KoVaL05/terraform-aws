#!/bin/bash
SECRETS=$(aws secretsmanager get-secret-value --secret-id aethera_flutter_app --query SecretString --output text)

echo "VERSION = $(echo $SECRETS | jq -r .version)" > .env