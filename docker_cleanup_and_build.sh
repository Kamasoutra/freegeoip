#!/bin/bash

IMAGE_NAME="kamasoutra/freegeoip-arm64"
TAG="latest"
DOCKERFILE_DIR="."
TARGET_PLATFORM="linux/arm64"

# Clean up Docker
echo "Cleaning up Docker..."
docker system prune -af

# Build the Docker image
echo "Building the Docker image..."
docker buildx build --platform $TARGET_PLATFORM --no-cache -t $IMAGE_NAME:$TAG $DOCKERFILE_DIR

# Tag the image for Docker Hub
echo "Tagging the Docker image..."
docker tag $IMAGE_NAME:$TAG $IMAGE_NAME

# Push the image to Docker Hub
echo "Pushing the Docker image to Docker Hub..."
docker push $IMAGE_NAME

echo "Docker cleanup, build, tag, and push complete!"
