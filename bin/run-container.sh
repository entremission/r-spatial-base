#!/bin/bash
#
# run-container.sh
#
# This is a simple helper script to kick-off a container exection. Ensure the container is set.
# This script will read the following environment variables.
#   LOCAL_LIBS  Uses local libraries. Requires $HRIS_PYTHON_LIB and $HRIS_R_LIB to be set.
#   DEBUG       Gives a prompt in the container instead of running the container.
#   COPY        Indicates if the sample data should be copied onto the data folder.

CONTAINER="tesera/r-spatial-base:4.1.1"

AWS_ACCESS_KEY_ID=$(aws --profile default configure get aws_access_key_id)
AWS_SECRET_ACCESS_KEY=$(aws --profile default configure get aws_secret_access_key)

if [ ! -z ${DEBUG+x} ] && $DEBUG; then
  echo "debug mode"
  DEBUG="--entrypoint /bin/bash"
else
  DEBUG=""
fi

COMMAND="docker run $DEBUG $CONTAINER $@"
echo $COMMAND

eval $COMMAND