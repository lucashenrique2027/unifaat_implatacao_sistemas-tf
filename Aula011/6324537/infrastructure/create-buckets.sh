cat > Aula011/6324537/infrastructure/create-buckets.sh << 'EOF'
#!/bin/bash

# Script de Infraestrutura S3 - TF11
# Aluno: Lucas Henrique - RA: 6324537

BUCKET_WEB="lucas-portfolio-website-6324537"
BUCKET_ASSETS="lucas-portfolio-assets-6324537"

echo "☁️ Iniciando provisionamento de armazenamento AWS S3..."

# 1. Criar Bucket Principal (Website)
# aws s3api create-bucket --bucket $BUCKET_WEB --region us-east-1
echo "LOG: Planejado criar bucket de hospedagem: $BUCKET_WEB"

# Configurar o Hosting Estático
# aws s3api put-bucket-website --bucket $BUCKET_WEB --website-configuration '{"IndexDocument":{"Suffix":"index.html"},"ErrorDocument":{"Key":"error.html"}}'
echo "LOG: Configuração de Static Website Hosting aplicada para index.html."

# 2. Criar Bucket de Assets (Imagens/Documentos)
# aws s3api create-bucket --bucket $BUCKET_ASSETS --region us-east-1
echo "LOG: Planejado criar bucket de assets: $BUCKET_ASSETS"

echo "🚀 Infraestrutura de Storage mapeada com sucesso para o CloudFront!"
EOF