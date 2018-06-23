#!/bin/bash

# this script bootstraps the docker container by:
#   1. downloading the release tar from s3
#   2. unzipping it
#   3. running it

echo "# downloading release: ${APP_NAME}/${RELEASE_TAR_PATH}"
aws s3 cp \
  "s3://${S3_BUCKET}/${RELEASE_TAR_PATH}" \
  /tmp/

echo "# unzipping the release"
tar xvzf /tmp/${RELEASE_TAR_PATH}

echo "# starting the release"
bin/${APP_NAME} foreground
