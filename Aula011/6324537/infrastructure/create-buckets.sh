#!/bin/bash
set -e

BUCKET_WEB="lucas-portfolio-website-6324537"
BUCKET_ASSETS="lucas-portfolio-assets-6324537"
REGION="us-east-1"

function create_bucket() {
    local bucket="$1"
    if aws s3api head-bucket --bucket "$bucket" 2>/dev/null; then
        echo "Bucket $bucket já existe. Pulando criação."
        return
    fi

    if [ "$REGION" = "us-east-1" ]; then
        aws s3api create-bucket --bucket "$bucket" --region "$REGION"
    else
        aws s3api create-bucket --bucket "$bucket" --region "$REGION" --create-bucket-configuration LocationConstraint="$REGION"
    fi
    echo "Bucket criado: $bucket"
}

echo "Criando buckets S3..."
create_bucket "$BUCKET_WEB"
create_bucket "$BUCKET_ASSETS"

echo "Configurando hospedagem estática para $BUCKET_WEB..."
aws s3 website "s3://$BUCKET_WEB" --index-document index.html --error-document error.html

echo "Habilitando versionamento..."
aws s3api put-bucket-versioning --bucket "$BUCKET_WEB" --versioning-configuration Status=Enabled
aws s3api put-bucket-versioning --bucket "$BUCKET_ASSETS" --versioning-configuration Status=Enabled

echo "Publicando conteúdo para $BUCKET_WEB..."
aws s3 sync ../website/ "s3://$BUCKET_WEB/" --acl public-read

echo "Buckets criados e site publicado com sucesso."
