#!/bin/bash

# this script bootstraps the docker container by:
#   1. downloading the release tar from s3
#   2. unzipping it
#   3. running it

sleep 1d

RELEASE_TAR_FILENAME="$(basename "$RELEASE_TAR_PATH")"
S3_PATH="s3://${S3_BUCKET}/${RELEASE_TAR_PATH}"

echo "# downloading release: ${S3_PATH}"
aws s3 cp "${S3_PATH}" /tmp/

echo "# unzipping the release"
tar xvzf /tmp/${RELEASE_TAR_FILENAME}

echo "# starting the release"
bin/${APP_NAME} foreground
