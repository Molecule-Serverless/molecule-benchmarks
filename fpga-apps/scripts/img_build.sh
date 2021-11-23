#!/bin/bash
cd ../
docker build -t ddnirvana/molecule-ae-fpga-bench:latest . -f ./scripts/Dockerfile
docker push ddnirvana/molecule-ae-fpga-bench:latest
