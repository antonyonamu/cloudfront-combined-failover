#!/usr/bin/env bash
if [[ $# -ge 4 ]]; then
    export AWS_REGION=$2
    export DOMAIN_NAME=$3
    export HOSTED_ZONE_ID=$4
    npx cdk destroy --require-approval never
    export AWS_REGION=$1
    npx cdk destroy --require-approval never
    exit $?
else
    echo 1>&2 "Provide AWS Region, AWS Backup Region, Domain-name and Hosted-Zone-ID as args."
    echo 1>&2 "Additional args are passed through to cdk deploy."
    echo 1>&2 "Example: destroy.sh eu-west-1 us-east-1 mydomain.com Z0XXXXXXXXXXXX"
    exit 1
fi