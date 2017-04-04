#!/bin/bash
set -euo pipefail

ECR_DOMAIN=erstaples
IMAGE_NAME="localnetes"
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

build $IMAGE_NAME

PUSH=${1:-}
if [ "$PUSH" == "push" ]
then
  push $IMAGE_NAME
fi


