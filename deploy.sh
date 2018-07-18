#!/bin/bash
set -eou pipefail

pulumi ${1:-preview} --stack pulumi/codeship-example-${CI_BRANCH} --non-interactive "${@:2}"