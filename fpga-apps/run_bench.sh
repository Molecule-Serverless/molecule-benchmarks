#!/bin/bash

sudo rm -rf test_env
mkdir test_env
cd test_env && mkdir -p rootfs
sudo docker export `docker create ddnirvana/molecule-ae-fpga-bench:latest` | sudo tar -C ./rootfs -xf -

cp ../scripts/gzip_small_config.json ./config.json


#cd gzip_app && ./eval.sh && cd ..
#cd anti_money/anti_money_genbin && ../eval.sh && cd ../..
