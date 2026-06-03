#!/bin/bash
set -e

BUCKET_WEB="lucas-portfolio-website-6324537"
BUCKET_ASSETS="lucas-portfolio-assets-6324537"

echo "Aplicando políticas de segurança nos buckets S3..."

aws s3api put-public-access-block --bucket "$BUCKET_WEB" --public-access-block-configuration BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false
aws s3api put-public-access-block --bucket "$BUCKET_ASSETS" --public-access-block-configuration BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true

cat > /tmp/${BUCKET_WEB}-policy.json <<JSON
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::$BUCKET_WEB/*"
    }
  ]
}
JSON

aws s3api put-bucket-policy --bucket "$BUCKET_WEB" --policy file:///tmp/${BUCKET_WEB}-policy.json

echo "Políticas aplicadas. Revise a política do bucket se usar OAI/OAC no CloudFront." 
