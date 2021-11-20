#!/bin/bash
XCLBIN_SRCPATH=../examples/xilinx/library_examples/anti_money_laundering/build_dir.hw.xilinx_aws-vu9p-f1_shell-v04261818_201920_2

XCLBIN=aml.xclbin
OUTBIN=acc_bin
HOSTBIN=../examples/xilinx/library_examples/anti_money_laundering/test_aml

cp $XCLBIN_SRCPATH/$XCLBIN .
cp $HOSTBIN .
../tools/create_vitis_afi.sh -xclbin=./$XCLBIN -o=./$OUTBIN -s3_bucket=dd-fpga-test -s3_dcp_key=helloworld -s3_logs_key=helloworld-log
