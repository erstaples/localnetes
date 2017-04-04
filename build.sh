#!/bin/bash
set -euo pipefail

ECR_DOMAIN=erstaples


IMAGE_NAME="localnetes"

## if unset, use tag
VERSION=0.0.1

function build {
  time docker build -f "Dockerfile/Dockerfile.$1" -t $1 .
}

function push {
  FULL_IMAGE_NAME=${ECR_DOMAIN}/${1}:${VERSION}
  echo pushing $FULL_IMAGE_NAME
  docker tag ${1}  ${FULL_IMAGE_NAME}
  docker push  ${FULL_IMAGE_NAME}
}

build $image_name

PUSH=${1:-}
if [ "$PUSH" == "push" ]
then
  push $image_name
fi


