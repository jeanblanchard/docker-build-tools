#!/usr/bin/env sh

# Exit on first error
set -e

# Read parameters
. `dirname $0`/parseargs.sh

# Parameters check

if [ "$SHOW_HELP" = "true" ] || [ -z "$IMAGE_NAME" ]; then
  echo "Usage: $0 [options]"
  echo
  echo "Options:"
  echo " -n, --name, --image-name <name>    The name of the docker image to build. REQUIRED"
  echo " -o, --owner, --image-owner <owner> The owner of the image to pull from the hub"
  echo " -l, --local-name <name>            The name of the local image to tag. Defaults to the image name"
  echo " -t, --tags, --image-tags <tags>    A list of tags, separated with spaces, the first of which is pulled"
  echo " -h, --help                         Display this message"
  echo
  echo "Environment variables:"
  echo " HUB_USERNAME:   The username to use to connect to the Docker Hub"
  echo " HUB_PASSWORD:   The username to use to connect to the Docker Hub"
  echo
  echo "The image is published only if the imagename, owner, tags, and the hub parameters, are all set."
  echo
  if [ "$SHOW_HELP" = "true" ]; then
    exit
  else
    exit 1
  fi
fi

# Publish

if [ -n "$HUB_USERNAME" ] && [ -n "$HUB_PASSWORD" ] && [ -n "$IMAGE_OWNER" ] && [ -n "$IMAGE_NAME" ] && [ -n "$IMAGE_TAGS" ]; then
  echo
  echo "###"
  echo "### Logging in to Docker Hub"
  echo "###"
  docker login -u ${HUB_USERNAME} -p ${HUB_PASSWORD}

  # Publish every tag
  for IMAGE_TAG in ${IMAGE_TAGS}; do
    echo
    echo "###"
    echo "### Building tag $IMAGE_OWNER/$IMAGE_NAME:$IMAGE_TAG"
    echo "###"
    docker tag ${LOCAL_NAME} ${IMAGE_OWNER}/${IMAGE_NAME}:${IMAGE_TAG}
    echo
    echo "###"
    echo "### Pushing tag $IMAGE_OWNER/$IMAGE_NAME:$IMAGE_TAG"
    echo "###"
    docker push ${IMAGE_OWNER}/${IMAGE_NAME}:${IMAGE_TAG}
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
