#!/usr/bin/env sh

# Exit on first error
set -e

# Parameters check

if [ -z "$IMAGE_NAME" ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  echo "Please set the following environment variables:"
  echo "  IMAGE_NAME:     The name of the docker image to build"
  echo "  IMAGE_OWNER:    The owner of the image to pull from the hub"
  echo "  DOCKERFILE_DIR: The folder where the dockerfile is. Defaults to the current folder"
  echo
  echo "Additionnaly, if you wish to pull from the Docker hub, you can set:"
  echo "  IMAGE_OWNER:    The owner of the image to pull from the hub"
  echo "  IMAGE_TAGS:     A list of tags, separated with spaces, the first of which is pulled"
  exit -1
fi

if [ -z "$DOCKERFILE_DIR" ]; then
  DOCKERFILE_DIR=.
fi

# Build

if [ -n "$HUB_USERNAME" ]; then
  echo
  echo "###"
  echo "### Fetching previous versions of $HUB_USERNAME/$IMAGE_NAME to avoid duplicating layers"
  echo "###"
  docker pull $IMAGE_OWNER/$IMAGE_NAME:$(echo \"$IMAGE_TAGS\" | awk '{print $1}') || true
fi

echo
echo "###"
echo "### Building $IMAGE_NAME from $DOCKERFILE_DIR"
echo "###"
docker build -t $IMAGE_NAME $DOCKERFILE_DIR
