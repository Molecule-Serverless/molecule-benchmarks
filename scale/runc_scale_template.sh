#!/bin/bash

RUNC=runc

cd ~/container0

echo start template-sandbox
sudo ~/devlop/serverless/molecule-faas/runc/runc run -d python-test

cd ~/devlop/serverless/molecule-faas/rfork/benchmarks/concurrent-fork-container-latency/.base/spin0

echo start func container
sudo runc run -d app-test

#cd back
cd ~/devlop/serverless/molecule-faas/molecule-benchmarks/scale
