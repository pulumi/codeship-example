#!/bin/bash
set -eou pipefail

cd /app
echo "CI_NAME=${CI_NAME}"
yarn install
yarn run build
pulumi preview --stack pulumi/codeship-example-master --non-interactive

