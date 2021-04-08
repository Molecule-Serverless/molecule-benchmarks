#!/bin/bash

RUNCTEST_PATH=$(pwd)
#RUNC=/home/yelly/.dd/runc/gopath/src/github.com/opencontainers/runc/runc
RUNC=runc


echo RUNCTEST_PATH at $RUNCTEST_PATH
echo generate RootFS first


#$RUNCTEST_PATH/rootfs_generator.sh ddnirvana/cuckoo-testenv-nodejs:v0.1
$RUNCTEST_PATH/rootfs_generator.sh ddnirvana/molecule-tests:nodejs-v0.1

echo test hello start

#echo cp hello config file here
#cp $RUNCTEST_PATH/nodejs-config-hello-boot-runc.json ./config.json

echo cp loop config file here
cp $RUNCTEST_PATH/nodejs-config-loop-boot-runc.json ./config.json

echo remove old results files
rm hello-nodejs-results.txt app-nodejs-results.txt -f

for ((i=1;i<100;i++))
do
    #$RUNCTEST_PATH/runc_single2.sh $RUNC >> hello-nodejs-results.txt
    ./begin_time >> loop-nodejs-results.txt
    #sudo  $RUNC  run mycontainer-6
    sudo  $RUNC  run mycontainer_$i >> loop-nodejs-results.txt &
    sleep 1
    echo currently running instances: $i
    #sleep 1
    #sudo  $RUNC  kill mycontainer-6
    #sudo  $RUNC  delete mycontainer-6
done

sleep 3
for ((i=1;i<100;i++))
do
    #sudo  $RUNC  kill mycontainer_$i
    #sudo  $RUNC  delete mycontainer_$i
    sudo  $RUNC  kill mycontainer_$i KILL
done

#echo test app start
#echo cp app config file here
#cp $RUNCTEST_PATH/nodejs-config-app-boot-runc.json ./config.json
#
#for ((i=1;i<100;i++))
#do
#    #$GVISORTEST_PATH/runc_single2.sh $RUNC >> app-nodejs-results.txt
#    ./begin_time
#    sudo  $1  run mycontainer-6
#    sleep 1
#    sudo  $1  kill mycontainer-6
#    sudo  $1  delete mycontainer-6
#done
#

