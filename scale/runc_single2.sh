#!/bin/bash
    #/home/dd/devlop/serverless/gvisor/gvisorTests/begin_time
    #date -I'ns'

    ./begin_time
    sudo  $1  run mycontainer-6
    sleep 1
    sudo  $1  kill mycontainer-6
    sudo  $1  delete mycontainer-6
