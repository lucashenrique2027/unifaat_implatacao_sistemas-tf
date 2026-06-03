#!/bin/bash
set -e

BUCKET_WEB="lucas-portfolio-website-6324537"
BUCKET_ASSETS="lucas-portfolio-assets-6324537"

echo "Removendo objetos e buckets S3..."
aws s3 rm "s3://$BUCKET_WEB" --recursive || true
aws s3 rb "s3://$BUCKET_WEB" --force || true
aws s3 rm "s3://$BUCKET_ASSETS" --recursive || true
aws s3 rb "s3://$BUCKET_ASSETS" --force || true

echo "Recursos S3 removidos. Verifique CloudFront, Lambda, DynamoDB e API Gateway no console AWS." 
