#!/bin/bash

export LD_LIBRARY_PATH=/opt/Xilinx/Vivado/2021.1/tps/lnx64/gcc-6.2.0/lib:/usr/local/lib:/usr/lib:/usr/local/lib64/:/usr/lib64/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/Xilinx/Vivado/2021.1/tps/lnx64/gcc-6.2.0/lib64:$LD_LIBRARY_PATH

echo "Run Anti-MoneyL Tests (Taking for minutes)"

./test_aml -xclbin acc_bin.awsxclbin -d ./data/ -c 2 > anti_money_results_small.txt 2>&1
./test_aml -xclbin acc_bin.awsxclbin -d ./data-60K/ -c 2 > anti_money_results_60k.txt 2>&1
./test_aml -xclbin acc_bin.awsxclbin -d ./data-mid/ -c 2 > anti_money_results_mid.txt 2>&1
./test_aml -xclbin acc_bin.awsxclbin -d ./data-huge/ -c 2 > anti_money_results_huge.txt 2>&1

# echo "Note: we should remove the 0.339s costs as the startup latency"
echo "Case-1: 6K entries"
tail -n 14 anti_money_results_small.txt
echo ""

echo "Case-2: 60K entries"
tail -n 14 anti_money_results_60k.txt
echo ""

echo "Case-3: 600K entries"
tail -n 14 anti_money_results_mid.txt
echo ""

echo "Case-4: 6M entries"
tail -n 14 anti_money_results_huge.txt
echo ""
