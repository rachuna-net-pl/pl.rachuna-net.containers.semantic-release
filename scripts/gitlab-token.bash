#!/bin/bash

echo -e "\033[1;33m===>\033[0m Przygotowanie kluczy SSH"

if [[ -z "$GITLAB_TOKEN" ]]; then
  echo "⚠️ GITLAB_TOKEN nie jest ustawione, spróbuje pobrać"
  if [[ -z "$VAULT_ADDR" ]]; then
    echo "❌ Błąd: VAULT_ADDR nie jest ustawione"
    exit 1
  fi
  if [[ -z "$VAULT_TOKEN" ]]; then
    echo "❌ Błąd: VAULT_TOKEN nie jest ustawione"
    exit 1
  fi
  
  export GITLAB_TOKEN=$(curl -s -H "X-Vault-Token: $VAULT_TOKEN" $VAULT_ADDR/v1/kv-gitlab/data/pl.rachuna-net/auth/gitlab | jq -r .data.data.GITLAB_TOKEN)
  echo "🔑 Pobrano GITLAB_TOKEN z vault."
fi