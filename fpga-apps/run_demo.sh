#!/bin/bash

sudo rm -rf test_env
mkdir test_env
cd test_env

mkdir -p rootfs
sudo docker export `sudo docker create ddnirvana/molecule-ae-fpga-bench:latest` | sudo tar -C ./rootfs -xf -

cp ../helloworld/helloworld_config.json ./config.json


cp ../helloworld/func_invoker ./
cp ../helloworld/fpga_func.awsxclbin ./

echo -e "Cold Run"
../../../vsandbox-runtime/vsandbox run demo-sandbox | grep -E 'latencies'
echo -e "Warm Run"
../../../vsandbox-runtime/vsandbox run demo-sandbox | grep -E 'latencies'
