#!/bin/bash

set -ue

pwd_dir="$(cd $(dirname $0) && pwd)"

env_name='test'
read -p "Environ name. [${env_name}]: " env_name_input
test -n "${env_name_input}" && env_name=${env_name_input}

region='ap-northeast-1'
read -p "Specify AWS region. [${region}]: " region_input
test -n "${region_input}" && region=${region_input}

artifact_bucket_name="${env_name}-sam-practice-bucket"
read -p "Input artifact bucket name. [${artifact_bucket_name}]: " artifact_bucket_name_input
test -n "${artifact_bucket_name_input}" && artifact_bucket_name=${artifact_bucket_name_input}

echo "Create artifact bucket. [${artifact_bucket_name}]"
aws s3api create-bucket \
    --bucket ${artifact_bucket_name} \
    --create-bucket-configuration LocationConstraint=${region} \
    --object-ownership BucketOwnerEnforced

echo "Enable block public access. [${artifact_bucket_name}]"
aws s3api put-public-access-block \
    --bucket ${artifact_bucket_name} \
    --public-access-block-configuration BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true
