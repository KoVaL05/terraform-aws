#!/bin/bash
SECRETS=$(aws secretsmanager get-secret-value --secret-id aethera_flutter_app --query SecretString --output text)

echo "USER_POOL_ID = $(echo $SECRETS | jq -r .userPoolId)" > .env
echo "CLIENT_POOL_ID = $(echo $SECRETS | jq -r .clientPoolId)" >> .env
