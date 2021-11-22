#!/bin/bash

## This script is used to build Molecule application images
## And upload the docker image into dockerhub

function prepare_img(){
	pushd $2 > /dev/null
	docker build -t ddnirvana/molecule-ae-app-$1-base:latest .
	docker push ddnirvana/molecule-ae-app-$1-base:latest

	gcc spin.c -o spin -O2 -static && docker build -t ddnirvana/molecule-ae-app-$1-ep:latest .
	docker push ddnirvana/molecule-ae-app-$1-ep:latest

	popd > /dev/null

}

echo "Preparing images for Function-bench Tests"

prepare_img linpack ../../functionBench/molecule/linpack
prepare_img chameleon ../../functionBench/molecule/chameleon
prepare_img matmul ../../functionBench/molecule/matmul
prepare_img pyaes ../../functionBench/molecule/pyaes
prepare_img video-processing ../../functionBench/molecule/video_processing
prepare_img dd ../../functionBench/molecule/dd
prepare_img gzip-compression ../../functionBench/molecule/gzip_compression

## Prepare template image
pushd ../../functionBench/molecule/python-template
docker build -t ddnirvana/molecule-ae-python-base-image:latest .
docker push ddnirvana/molecule-ae-python-base-image:latest
popd
