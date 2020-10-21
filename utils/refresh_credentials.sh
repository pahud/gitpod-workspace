#!/bin/bash

# This script generates AWS Programmatic Access credentials from a user authenticated via SSO
# Before using, make sure that the AWS SSO is configured in your CLI: `aws configure sso`

profile=${AWS_PROFILE-default}
temp_identity=$(aws --profile "$profile" sts get-caller-identity)
account_id=$(echo $temp_identity | jq -r .Arn | cut -d: -f5)
assumed_role_name=$(echo $temp_identity | jq -r .Arn | cut -d/ -f2)
role_arn="arn:aws:iam::${account_id}:role/aws-reserved/sso.amazonaws.com/${assumed_role_name}"
session_name=$(echo $temp_identity | jq -r .Arn | cut -d/ -f3)

request_credentials() {
  credentials=$(
    aws sts assume-role \
      --profile $profile \
      --role-arn $role_arn \
      --role-session-name $session_name
  )
}

echo "=> requesting temporary credentials"
request_credentials

if [ $? -ne 0 ]; then
  aws sso login --profile "$profile"

  if [ $? -ne 0 ]; then
    exit 1
  fi

  request_credentials
fi

echo "=> updating ~/.aws/credentials as profile $profile"

access_key_id=$(echo $credentials | perl -n -e'/"AccessKeyId": "([^,]+)"/ && print $1')
secret_key_id=$(echo $credentials | perl -n -e'/"SecretAccessKey": "([^,]+)"/ && print $1')
session_token=$(echo $credentials | perl -n -e'/"SessionToken": "([^,]+)"/ && print $1')

aws configure set --profile "$profile" aws_access_key_id "$access_key_id"
aws configure set --profile "$profile" aws_secret_access_key "$secret_key_id"
aws configure set --profile "$profile" aws_session_token "$session_token"

echo "[OK] done"

