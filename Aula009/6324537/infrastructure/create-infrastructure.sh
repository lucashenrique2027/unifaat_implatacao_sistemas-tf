cat > infrastructure/create-infrastructure.sh << 'EOF'
#!/bin/bash

# Script de Infraestrutura para o TF09 - Lucas Henrique (RA: 6324537)
# Este script contém a lógica para criação da VPC, Subnets e Security Groups via AWS CLI

echo "🚀 Planejamento de Infraestrutura AWS..."

# 1. Criar VPC
# VPC_ID=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query 'Vpc.VpcId' --output text)
echo "LOG: Comando planejado para criar VPC 10.0.0.0/16"

# 2. Criar Subnet Pública
# PUBLIC_SUBNET_ID=$(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.1.0/24)
echo "LOG: Comando planejado para criar Subnet Pública"

# 3. Criar Security Group e Liberar Portas
# aws ec2 authorize-security-group-ingress --group-id $SG_ID --protocol tcp --port 22 --cidr 0.0.0.0/0
# aws ec2 authorize-security-group-ingress --group-id $SG_ID --protocol tcp --port 80 --cidr 0.0.0.0/0
# aws ec2 authorize-security-group-ingress --group-id $SG_ID --protocol tcp --port 3000 --cidr 0.0.0.0/0
echo "LOG: Configuração de Firewall (Portas 22, 80 e 3000) preparada."

echo "🎯 Script de automação pronto para execução pós-configuração de conta."
EOFcd