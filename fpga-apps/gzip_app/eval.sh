#!/bin/bash

echo "Run Gzip Tests"

# Warmup
./xil_gzip -sx acc_bin.awsxclbin -c small_file.txt > /dev/null 2>&1


# echo "Note: we should remove the 0.339s costs as the startup latency"
echo "small file (1.3KB)"
echo -e "\tFPGA function:"
\time -f "\t\t%E (minutes:seconds)" ./xil_gzip -sx acc_bin.awsxclbin -c small_file.txt | grep minutes
echo -e "\tCPU function:"
\time -f "\t\t%E (minutes:seconds)" gzip -c small_file.txt > small_file.tar.gz | grep minutes


echo ""
echo "mid file (2.5MB)"
echo -e "\tFPGA function:"
\time -f "\t\t%E (minutes:seconds)" ./xil_gzip -sx acc_bin.awsxclbin -c mid_file.txt | grep minutes
echo -e "\tCPU function:"
\time -f "\t\t%E (minutes:seconds)" gzip -c mid_file.txt > mid_file.tar.gz | grep minutes

echo ""
echo "huge file (2.5MB)"
echo -e "\tFPGA function:"
\time -f "\t\t%E (minutes:seconds)" ./xil_gzip -sx acc_bin.awsxclbin -c huge_file.txt | grep minutes
echo -e "\tCPU function:"
\time -f "\t\t%E (minutes:seconds)" gzip -c huge_file.txt > huge_file.tar.gz | grep minutes

echo ""
echo "Linux file (112MB)"
echo -e "\tFPGA function:"
\time -f "\t\t%E (minutes:seconds)" ./xil_gzip -sx acc_bin.awsxclbin -c linux-5.10.55.tar.xz | grep minutes
echo -e "\tCPU function:"
\time -f "\t\t%E (minutes:seconds)" gzip -c linux-5.10.55.tar.xz > linux-5.10.55.tar.xz.tar.gz | grep minutes


