#!/bin/bash

RUNC=runc

sudo runc delete -f python-test
sudo runc delete -f app-test

