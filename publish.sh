#!/usr/bin/env sh

# Exit on first error
set -e

# Parameters check

if [ -z "$IMAGE_NAME" ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  echo "Please set the following environment variables:"
  echo "  IMAGE_NAME:     The name of the docker image to build"
  echo "  DOCKERFILE_DIR: The folder where the dockerfile is. Defaults to the current folder"
  echo
  echo "Additionnaly, to publish to the Docker hub, you can set:"
  echo "  IMAGE_TAGS:     A list of tags to publish, separated with spaces"
  echo "  IMAGE_OWNER:    The owner of the image to pull from the hub"
  echo "  HUB_USERNAME:   The username to use to connect to the Docker Hub"
  echo "  HUB_PASSWORD:   The username to use to connect to the Docker Hub"
  echo "  HUB_EMAIL:      The username to use to connect to the Docker Hub"
  exit -1
fi

if [ -z "$DOCKERFILE_DIR" ]; then
  DOCKERFILE_DIR=.
fi

# Publish

if [ -n "$HUB_USERNAME" ] && [ -n "$HUB_PASSWORD" ]; then
  echo
  echo "###"
  echo "### Logging in to Docker Hub"
  echo "###"
  docker login -u $HUB_USERNAME -p $HUB_PASSWORD -e $HUB_EMAIL

  # Publish every tag
  for IMAGE_TAG in $IMAGE_TAGS; do
    echo
    echo "###"
    echo "### Building tag $IMAGE_OWNER/$IMAGE_NAME:$IMAGE_TAG"
    echo "###"
    docker build -t $IMAGE_OWNER/$IMAGE_NAME:$IMAGE_TAG $DOCKERFILE_DIR
    echo
    echo "###"
    echo "### Pushing tag $IMAGE_OWNER/$IMAGE_NAME:$IMAGE_TAG"
    echo "###"
    docker push $IMAGE_OWNER/$IMAGE_NAME:$IMAGE_TAG
    echo
    echo "###"
    echo "### Tag $IMAGE_TAG sucessfully published"
    echo "###"
  done

  echo
  echo "###"
  echo "### Logging out from Docker Hub"
  echo "###"
  docker logout
else
  echo
  echo "###"
  echo "### Not publishing!"
  echo "###"
fi
