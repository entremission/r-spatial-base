#!/bin/sh

FORCE_REBUILD=false
CONTAINER="tesera/r-spatial-base:4.1.1"

aws ecr get-login-password --region us-west-2 --profile hris-development | docker login --username AWS --password-stdin 940145619248.dkr.ecr.us-west-2.amazonaws.com

usage() { printf "Usage: $0 [-f]\n  -f  Force docker re-build from nothing. (uses docker --no-cache)\n" 1>&2; exit 1; }

while getopts ":fh" opt; do
  case $opt in
    f)
      FORCE_REBUILD=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      exit 1
      ;;
    h)
      usage
      exit 0;
      ;;
  esac
done

if $FORCE_REBUILD; then
    docker build --no-cache -t $CONTAINER .
else
    docker build -t $CONTAINER .
fi
