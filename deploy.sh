#!/bin/bash

set -e

echo "Iniciando deploy do Local Data Stack..."

cd infra/live/dev/airflow/init
terragrunt apply --terragrunt-non-interactive
cd - > /dev/null

# Fix PostgreSQL data directory permissions (UID 70 = postgres user in container)
sudo chown -R 70:70 stack/postgres
# Fix Airflow directory permissions (UID 50000 = airflow user in container)
sudo chown -R 50000:0 stack/airflow

echo "Aguardando..."
sleep 5

cd infra/live/dev/airflow
terragrunt run-all apply --terragrunt-non-interactive --terragrunt-exclude-dir init