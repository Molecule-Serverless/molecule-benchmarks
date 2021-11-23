#!/bin/bash

sudo rm -rf test_env
mkdir test_env
cd test_env

mkdir -p rootfs
sudo docker export `sudo docker create ddnirvana/molecule-ae-fpga-bench:latest` | sudo tar -C ./rootfs -xf -

cp ../scripts/gzip_small_config.json ./config.json


cp ../gzip_app/small_file.txt ./
cp ../gzip_app/mid_file.txt ./
cp ../gzip_app/huge_file.txt ./
cp ../gzip_app/linux-5.10.55.tar.xz ./

../scripts/eval_gzip.sh

#cd gzip_app && ./eval.sh && cd ..
#cd anti_money/anti_money_genbin && ../eval.sh && cd ../..
