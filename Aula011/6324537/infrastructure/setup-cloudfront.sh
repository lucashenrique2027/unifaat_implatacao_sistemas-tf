#!/bin/bash
set -euo pipefail

BUCKET_WEB="lucas-portfolio-website-6324537"
REGION="us-east-1"
WORKDIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_FILE="$WORKDIR/cloudfront-distribution-config.json"

echo "🔐 Criando Origin Access Identity (OAI) para CloudFront..."
# Criar OAI e obter Id e S3CanonicalUserId
OAI_ID=$(aws cloudfront create-cloud-front-origin-access-identity --cloud-front-origin-access-identity-config "{\"CallerReference\":\"tf11-$(date +%s)-$RANDOM\",\"Comment\":\"OAI for $BUCKET_WEB\"}" --query 'CloudFrontOriginAccessIdentity.Id' --output text)
OAI_CANONICAL_ID=$(aws cloudfront create-cloud-front-origin-access-identity --cloud-front-origin-access-identity-config "{\"CallerReference\":\"tf11-$(date +%s)-$RANDOM\",\"Comment\":\"OAI for $BUCKET_WEB\"}" --query 'CloudFrontOriginAccessIdentity.S3CanonicalUserId' --output text || true)

if [ -z "$OAI_ID" ]; then
  echo "Falha ao criar OAI ou OAI já existe. Verifique no console CloudFront." >&2
fi

ORIGIN_DOMAIN="$BUCKET_WEB.s3.amazonaws.com"

echo "📄 Aplicando política no bucket para permitir acesso do OAI..."
if [ -n "$OAI_CANONICAL_ID" ]; then
  cat > /tmp/${BUCKET_WEB}-oai-policy.json <<POL
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {"CanonicalUser": "$OAI_CANONICAL_ID"},
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::$BUCKET_WEB/*"
    }
  ]
}
POL

  aws s3api put-bucket-policy --bucket "$BUCKET_WEB" --policy file:///tmp/${BUCKET_WEB}-oai-policy.json || true
  echo "Política aplicada ao bucket $BUCKET_WEB para OAI."
else
  echo "Não foi possível obter S3CanonicalUserId do OAI — pulei a aplicação automática da policy."
fi

echo "☁️ Gerando configuração da distribuição CloudFront..."
cat > "$CONFIG_FILE" <<JSON
{
  "CallerReference": "tf11-portfolio-$(date +%s)-$RANDOM",
  "Comment": "Distribuição CloudFront para portfólio estático S3 (OAI habilitado).",
  "Enabled": true,
  "Origins": {
    "Quantity": 1,
    "Items": [
      {
        "Id": "S3Origin",
        "DomainName": "$ORIGIN_DOMAIN",
        "S3OriginConfig": {
          "OriginAccessIdentity": "origin-access-identity/cloudfront/$OAI_ID"
        }
      }
    ]
  },
  "DefaultRootObject": "index.html",
  "DefaultCacheBehavior": {
    "TargetOriginId": "S3Origin",
    "ViewerProtocolPolicy": "redirect-to-https",
    "AllowedMethods": {
      "Quantity": 3,
      "Items": ["GET", "HEAD", "OPTIONS"]
    },
    "CachedMethods": {
      "Quantity": 2,
      "Items": ["GET", "HEAD"]
    },
    "Compress": true,
    "ForwardedValues": {
      "QueryString": false,
      "Cookies": { "Forward": "none" }
    },
    "DefaultTTL": 86400,
    "MaxTTL": 31536000,
    "MinTTL": 0
  },
  "ViewerCertificate": {
    "CloudFrontDefaultCertificate": true
  },
  "HttpVersion": "http2",
  "IsIPV6Enabled": true
}
JSON

echo "🚀 Criando distribuição CloudFront (pode demorar alguns minutos)..."
aws cloudfront create-distribution --distribution-config file://"$CONFIG_FILE"

echo "Distribuição CloudFront solicitada. Verifique o console AWS para o domínio gerado e aguarde a propagação."
