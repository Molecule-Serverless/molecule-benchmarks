#!/bin/bash

## This script is used to build Molecule application images
## And upload the docker image into dockerhub

function prepare_img(){
	pushd $2 > /dev/null

	cd baseline-image
	docker build -t ddnirvana/molecule-ae-app-$1-base:latest .
	docker push ddnirvana/molecule-ae-app-$1-base:latest

	cd ../spin-base-image
	gcc spin.c -o spin -O2 -static && docker build -t ddnirvana/molecule-ae-app-$1-ep:latest .
	docker push ddnirvana/molecule-ae-app-$1-ep:latest

	popd > /dev/null
}


echo "Preparing images for Serverlessbench Tests"

prepare_img image-resize ../../forkable-python-runtime

## Prepare template image
pushd ../../forkable-python-runtime/python-base-image
docker build -t ddnirvana/molecule-ae-serverlessbench-python-base-image:latest .
docker push ddnirvana/molecule-ae-serverlessbench-python-base-image:latest
popd
