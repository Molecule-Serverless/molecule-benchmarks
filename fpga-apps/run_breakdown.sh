#!/bin/bash

sudo rm -rf test_env
mkdir test_env
cd test_env

mkdir -p rootfs
sudo docker export `sudo docker create ddnirvana/molecule-ae-fpga-bench:latest` | sudo tar -C ./rootfs -xf -

cp ../startup_breakdown/breakdown_config.json ./config.json


cp ../startup_breakdown/func_invoker ./
cp ../startup_breakdown/fpga_func.awsxclbin ./

../../../vsandbox-runtime/FPGA_serverless_cli -b
