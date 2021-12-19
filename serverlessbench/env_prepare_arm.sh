#!/bin/bash

## This script is used to build Molecule application images
## And upload the docker image into dockerhub

function prepare_img(){
	pushd $2 > /dev/null

	cd baseline-image
	docker build -f ./Dockerfile-arm64 -t ddnirvana/molecule-ae-app-$1-base:latest-arm .
	docker push ddnirvana/molecule-ae-app-$1-base:latest-arm

	cd ../spin-base-image
	gcc spin.c -o spin -O2 -static
	docker build -f ./Dockerfile-arm64 -t ddnirvana/molecule-ae-app-$1-ep:latest-arm .
	docker push ddnirvana/molecule-ae-app-$1-ep:latest-arm

	popd > /dev/null
}


echo "Preparing images for Serverlessbench Tests"

prepare_img image-resize ../../forkable-python-runtime

## Prepare template image
pushd ../../forkable-python-runtime/python-base-image
docker build -f Dockerfile-arm64 -t ddnirvana/molecule-ae-serverlessbench-python-base-image:latest-arm .
docker push ddnirvana/molecule-ae-serverlessbench-python-base-image:latest-arm
popd
