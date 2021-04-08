#!/bin/bash

RUNC=runc

cd ~/container0

echo start template-sandbox
sudo ~/devlop/serverless/molecule-faas/runc/runc run -d python-test

cd ~/devlop/serverless/molecule-faas/rfork/benchmarks/concurrent-fork-container-latency/.base/spin0

echo start func container
sudo runc run -d app-test

echo start scale test up to 500 instances
for ((i=1;i<550;i++))
do
    #sudo  $RUNC  run mycontainer_$i >> loop-nodejs-results.txt &
    sudo ~/devlop/serverless/molecule-faas/runc/runc fork2container --zygote python-test --target app-test > /dev/null 2>&1
    sleep 0.01
    echo currently running instances: $i
done

#cd back
cd ~/devlop/serverless/molecule-faas/molecule-benchmarks/scale
