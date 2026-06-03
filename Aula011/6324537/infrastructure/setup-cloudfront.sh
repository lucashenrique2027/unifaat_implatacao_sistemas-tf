#!/bin/bash
set -e

BUCKET_WEB="lucas-portfolio-website-6324537"
REGION="us-east-1"
WORKDIR="$(cd "$(dirname "$0")" && pwd)"
ORIGIN_DOMAIN="$BUCKET_WEB.s3-website-$REGION.amazonaws.com"
CONFIG_FILE="$WORKDIR/cloudfront-distribution-config.json"

cat > "$CONFIG_FILE" <<JSON
{
  "CallerReference": "tf11-portfolio-$(date +%s)-$RANDOM",
  "Comment": "Distribuição CloudFront para portfólio estático S3.",
  "Enabled": true,
  "Origins": {
    "Quantity": 1,
    "Items": [
      {
        "Id": "S3WebsiteOrigin",
        "DomainName": "$ORIGIN_DOMAIN",
        "CustomOriginConfig": {
          "HTTPPort": 80,
          "HTTPSPort": 443,
          "OriginProtocolPolicy": "http-only",
          "OriginSslProtocols": {
            "Quantity": 1,
            "Items": ["TLSv1.2"]
          },
          "OriginReadTimeout": 30,
          "OriginKeepaliveTimeout": 5
        }
      }
    ]
  },
  "DefaultCacheBehavior": {
    "TargetOriginId": "S3WebsiteOrigin",
    "ViewerProtocolPolicy": "redirect-to-https",
    "AllowedMethods": {
      "Quantity": 2,
      "Items": ["GET", "HEAD"]
    },
    "CachedMethods": {
      "Quantity": 2,
      "Items": ["GET", "HEAD"]
    },
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

aws cloudfront create-distribution --distribution-config file://"$CONFIG_FILE"

echo "Distribuição CloudFront criada. Verifique o console AWS para o domínio gerado."
