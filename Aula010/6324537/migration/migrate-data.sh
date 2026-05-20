#!/bin/bash
set -euo pipefail

# Script de migração de dados do banco local para a instância RDS.
# Ajuste os valores de conexão conforme o ambiente.

LOCAL_DB_USER="postgres"
LOCAL_DB_NAME="northwind"
LOCAL_DB_HOST="localhost"
LOCAL_DB_PORT=5432
DUMP_FILE="northwind_dump.sql"

RDS_HOST="rds-endpoint-here.amazonaws.com"
RDS_PORT=5432
RDS_DB_NAME="northwind"
RDS_USER="admin"
RDS_PASSWORD="SenhaSegura123!"

export PGPASSWORD="$RDS_PASSWORD"

echo "Exportando schema e dados do banco local..."
pm_dump --username "$LOCAL_DB_USER" --host "$LOCAL_DB_HOST" --port "$LOCAL_DB_PORT" --format plain --file "$DUMP_FILE" "$LOCAL_DB_NAME"

echo "Importando dump para o RDS..."
psql --host "$RDS_HOST" --port "$RDS_PORT" --username "$RDS_USER" --dbname "$RDS_DB_NAME" --file "$DUMP_FILE"

echo "Migração concluída."
