#!/bin/bash
#sudo runc ps app-test | wc -l
#sudo runc ps app-test
sudo runc ps app-test | awk '{print "func:" $(NF), "language runtime:" $(NF-1)}'
