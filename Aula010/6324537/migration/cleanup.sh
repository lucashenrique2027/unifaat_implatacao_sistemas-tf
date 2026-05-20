#!/bin/bash
set -euo pipefail

# Script de limpeza de recursos criados durante a migração.
# Use com cuidado: removerá a instância RDS e recursos relacionados.

AWS_REGION="us-east-1"
DB_INSTANCE_IDENTIFIER="tf10-rds-6324537"
DB_SNAPSHOT_IDENTIFIER="tf10-rds-6324537-final-snapshot"

echo "Removendo instância RDS: $DB_INSTANCE_IDENTIFIER"
aws rds delete-db-instance \
  --region "$AWS_REGION" \
  --db-instance-identifier "$DB_INSTANCE_IDENTIFIER" \
  --skip-final-snapshot false \
  --final-db-snapshot-identifier "$DB_SNAPSHOT_IDENTIFIER"

echo "Limpeza iniciada. Aguarde a exclusão completa no console AWS."
