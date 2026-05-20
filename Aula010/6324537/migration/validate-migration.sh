#!/bin/bash
set -euo pipefail

# Validação básica da migração entre banco local e RDS.

LOCAL_DB_USER="postgres"
LOCAL_DB_NAME="northwind"
LOCAL_DB_HOST="localhost"
LOCAL_DB_PORT=5432

RDS_HOST="rds-endpoint-here.amazonaws.com"
RDS_PORT=5432
RDS_DB_NAME="northwind"
RDS_USER="admin"
RDS_PASSWORD="SenhaSegura123!"

export PGPASSWORD="$RDS_PASSWORD"

echo "Contando linhas nas tabelas críticas..."
TABLES=(customers orders order_details products employees)

for table in "${TABLES[@]}"; do
  local_count=$(psql --username "$LOCAL_DB_USER" --host "$LOCAL_DB_HOST" --port "$LOCAL_DB_PORT" --dbname "$LOCAL_DB_NAME" --tuples-only --no-align -c "SELECT COUNT(*) FROM $table;")
  rds_count=$(psql --host "$RDS_HOST" --port "$RDS_PORT" --username "$RDS_USER" --dbname "$RDS_DB_NAME" --tuples-only --no-align -c "SELECT COUNT(*) FROM $table;")
  echo "Tabela: $table -> local=$local_count, rds=$rds_count"
  if [ "$local_count" != "$rds_count" ]; then
    echo "ERRO: contagem divergente na tabela $table"
    exit 1
  fi
done

echo "Validação concluída: contagens de linha conferem para as tabelas críticas."
