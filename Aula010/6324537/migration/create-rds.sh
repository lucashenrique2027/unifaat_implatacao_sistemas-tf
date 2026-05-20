#!/bin/bash
set -euo pipefail

# Script de criação de instância RDS PostgreSQL
# Ajuste os valores abaixo antes de executar.

AWS_REGION="us-east-1"
DB_INSTANCE_IDENTIFIER="tf10-rds-6324537"
DB_INSTANCE_CLASS="db.t3.micro"
DB_ENGINE="postgres"
DB_ENGINE_VERSION="15.4"
DB_STORAGE=20
DB_USERNAME="admin"
DB_PASSWORD="SenhaSegura123!"
DB_NAME="northwind"
DB_ALLOCATED_STORAGE=20
DB_MULTI_AZ=true
DB_PUBLICLY_ACCESSIBLE=false
DB_BACKUP_RETENTION=7
DB_SUBNET_GROUP_NAME="tf10-subnet-group"
DB_SECURITY_GROUP_IDS="sg-xxxxxxxx"

echo "Criando instância RDS: $DB_INSTANCE_IDENTIFIER"
aws rds create-db-instance \
  --region "$AWS_REGION" \
  --db-instance-identifier "$DB_INSTANCE_IDENTIFIER" \
  --db-instance-class "$DB_INSTANCE_CLASS" \
  --engine "$DB_ENGINE" \
  --engine-version "$DB_ENGINE_VERSION" \
  --allocated-storage "$DB_ALLOCATED_STORAGE" \
  --master-username "$DB_USERNAME" \
  --master-user-password "$DB_PASSWORD" \
  --db-name "$DB_NAME" \
  --backup-retention-period "$DB_BACKUP_RETENTION" \
  --multi-az \
  --publicly-accessible "$DB_PUBLICLY_ACCESSIBLE" \
  --vpc-security-group-ids $DB_SECURITY_GROUP_IDS \
  --db-subnet-group-name "$DB_SUBNET_GROUP_NAME"

echo "Instância RDS criada. Aguarde a disponibilidade antes de migrar os dados."
