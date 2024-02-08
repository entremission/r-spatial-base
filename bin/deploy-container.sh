#!/bin/bash
#
# deploy-container.sh
#
# This is a simple helper script to deploy a container to amazon ecr.

CONTAINER="tesera/r-spatial-base"
ACCOUNT="940145619248"
REGION="us-west-2"
ECR_IMAGE_NAME="${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com/${CONTAINER}:4.1.1"
# DOCKERHUB_IMAGE_NAME="tesera/r-spatial-base:4.1.0"

# Login to AWS ECR
aws ecr get-login-password --region us-west-2 --profile hris-development

# Create a repository for $CONTAINER if not exists
if [[ -z `aws ecr describe-repositories | grep "$CONTAINER"` ]]; then
  echo "Creating Repository"
  REPO_CREATED=`aws ecr create-repository --repository-name "$CONTAINER"`
fi

# Push to AWS ECR
docker tag "${CONTAINER}:4.1.1" $ECR_IMAGE_NAME
docker push $ECR_IMAGE_NAME
docker rmi $ECR_IMAGE_NAME

# # Push to dockerhub
# docker tag "${CONTAINER}:4.1.0" $DOCKERHUB_IMAGE_NAME
# docker push $DOCKERHUB_IMAGE_NAME
