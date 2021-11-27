#!/bin/bash

echo "Run Gzip Tests"

cp ../scripts/gzip_small_config.json ./config.json

# Warmup
../../../vsandbox-runtime/vsandbox run gzip_func > /dev/null 2>&1
#./xil_gzip -sx acc_bin.awsxclbin -c small_file.txt > /dev/null 2>&1


# echo "Note: we should remove the 0.339s costs as the startup latency"
echo "small file (1.3KB)"
echo -e "\tFPGA function:"
\time -f "\t\t%E (minutes:seconds)" ../../../vsandbox-runtime/vsandbox run gzip_func | grep minutes
echo -e "\tCPU function:"
\time -f "\t\t%E (minutes:seconds)" gzip -c small_file.txt > small_file.tar.gz | grep minutes


cp ../scripts/gzip_mid_config.json ./config.json
echo ""
echo "mid file (2.5MB)"
echo -e "\tFPGA function:"
\time -f "\t\t%E (minutes:seconds)" ../../../vsandbox-runtime/vsandbox run gzip_func | grep minutes
echo -e "\tCPU function:"
\time -f "\t\t%E (minutes:seconds)" gzip -c mid_file.txt > mid_file.tar.gz | grep minutes

cp ../scripts/gzip_huge_config.json ./config.json
echo ""
echo "huge file (2.5MB)"
echo -e "\tFPGA function:"
\time -f "\t\t%E (minutes:seconds)" ../../../vsandbox-runtime/vsandbox run gzip_func | grep minutes
echo -e "\tCPU function:"
\time -f "\t\t%E (minutes:seconds)" gzip -c huge_file.txt > huge_file.tar.gz | grep minutes

cp ../scripts/gzip_linux_config.json ./config.json
echo ""
echo "Linux file (112MB)"
echo -e "\tFPGA function:"
\time -f "\t\t%E (minutes:seconds)" ../../../vsandbox-runtime/vsandbox run gzip_func | grep minutes
echo -e "\tCPU function:"
\time -f "\t\t%E (minutes:seconds)" gzip -c linux-5.10.55.tar.xz > linux-5.10.55.tar.xz.tar.gz | grep minutes


