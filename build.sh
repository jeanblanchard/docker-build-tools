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
  echo " -l, --local-name <name>            The name of the local image to build. Defaults to the image name"
  echo " -o, --owner, --image-owner <owner> The owner of the image to pull from the hub"
  echo " -d, --dir, --dockerfile-dir <dir>  The folder where the dockerfile is. Defaults to the current folder"
  echo " -t, --tags, --image-tags <tags>    A list of tags, separated with spaces, the first of which is pulled"
  echo " -h, --help                         Display this message"
  echo
  echo "If the owner and tags are set, then the previous version of the first tag is fetched from the repository, "
  echo "to avoid duplicating layers."
  echo
  if [ "$SHOW_HELP" = "true" ]; then
    exit
  else
    exit 1
  fi
fi

# Build

if [ -n "$IMAGE_OWNER" ]; then
  echo
  echo "###"
  echo "### Fetching previous versions of $IMAGE_OWNER/$IMAGE_NAME to avoid duplicating layers"
  echo "###"
  docker pull ${IMAGE_OWNER}/${IMAGE_NAME}:$(echo "${IMAGE_TAGS}" | awk '{print $1}') || true
fi

echo
echo "###"
echo "### Building $IMAGE_NAME from $DOCKERFILE_DIR"
echo "###"
docker build -t ${LOCAL_NAME} ${DOCKERFILE_DIR}
