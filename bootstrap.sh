#!/bin/bash

# this script bootstraps the docker container by:
#   0. copy the secrets.sh from our deployments folder and source it
#   1. downloading the release tar from s3
#   2. unzipping it
#   3. running it

# env vars that need to be defined
# 1. APP_NAME: the app name from your distillery config
# 2. S3_BUCKET: the s3 bucket where your releases are downloaded from
# 3. RELEASE_TAR_PATH: the path to your release tar
# 4. SSM_SECRET_NAME: the name of your parameter which contains the secrets

RELEASE_TAR_FILENAME="$(basename "$RELEASE_TAR_PATH")"
S3_PATH="s3://${S3_BUCKET}/${RELEASE_TAR_PATH}"

echo "# downloading release: ${S3_PATH}"
aws s3 cp "${S3_PATH}" /tmp/

echo "# unzipping the release"
tar xvzf /tmp/${RELEASE_TAR_FILENAME}

echo "# sourcing secrets from parameter store"
source <(aws ssm get-parameters --name "${SSM_SECRET_NAME}" | jq '.Parameters[0].Value' --raw-output)

echo "# starting the release"
exec bin/${APP_NAME} foreground
