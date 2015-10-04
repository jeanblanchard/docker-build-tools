#!/usr/bin/env sh

# Exit on first error
set -e

# Normalize the arguments using getopt
TEMP=`getopt -o hn:l:o:d:t: -l help,name:,image-name:,local-name:,owner:,image-owner:,dir:,dockerfile-dir:,tags:,image-tags: -n $0 -- "$@"`

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

eval set -- "${TEMP}"

SHOW_HELP=false
if [ -z "$DOCKERFILE_DIR" ]; then
  DOCKERFILE_DIR=.
fi
LOCAL_NAME=
while true; do
  case "$1" in
    -h | --help                     ) SHOW_HELP=true;      shift   ;;
    -n | --name  | --image-name     ) IMAGE_NAME="$2";     shift 2 ;;
    -l |           --local-name     ) LOCAL_NAME="$2";     shift 2 ;;
    -o | --owner | --image-owner    ) IMAGE_OWNER="$2";    shift 2 ;;
    -d | --dir   | --dockerfile-dir ) DOCKERFILE_DIR="$2"; shift 2 ;;
    -t | --tags  | --image-tags     ) IMAGE_TAGS="$2";     shift 2 ;;
    * ) break ;;
  esac
done

if [ -z "$LOCAL_NAME" ]; then
  LOCAL_NAME="$IMAGE_NAME"
fi
