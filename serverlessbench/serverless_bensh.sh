#!/bin/bash

## Invoke a single test
## Arg1: test-name
## Arg2: test-path
function run_test(){
	echo ""
	echo -e "\tTest-Case: $1 (taking 5-10 minutes)"
	./app_template_build_prebuilt.sh ddnirvana/molecule-ae-serverlessbench-python-base-image #> /dev/null 2>&1
	./app_base_build_prebuilt.sh ddnirvana/molecule-ae-app-$2-base #> /dev/null 2>&1
	./app_endpoint_build_prebuilt.sh ddnirvana/molecule-ae-app-$2-ep #> /dev/null 2>&1
	./kill_all.sh
	./run_fork.sh  > /dev/null 2>&1
	python3 ./test_app.py
	#python3 ./test_app.py baseline
}

#function run_test_long(){
#	echo ""
#	echo -e "\tTest-Case: $1 (taking about 30 minutes! please be patient!)"
#	./app_template_build_prebuilt.sh ddnirvana/molecule-ae-python-base-image #> /dev/null 2>&1
#	./app_base_build_prebuilt.sh ddnirvana/molecule-ae-app-$2-base #> /dev/null 2>&1
#	./app_endpoint_build_prebuilt.sh ddnirvana/molecule-ae-app-$2-ep #> /dev/null 2>&1
#	./kill_all.sh
#	./run_fork.sh > /dev/null 2>&1
#	python3 ./test_app_long.py
#	#python3 ./test_app.py baseline
#}


function run_test_friendly() {
	echo ""
	run_test $1 $2 &
	pid=$! # Process Id of the previous running command

	spin='-\|/'
	sleep 1

	i=0
	while kill -0 $pid 2>/dev/null
	do
		i=$(( (i+1) %4 ))
	    printf "\033[46;37m \r[${spin:$i:1}] Running\033[0m  "
		sleep .1
	done
	sleep 2
	echo -e "\033[42;37m Brilliant! Test case succeed!\033[0m"
}

function run_test_long_friendly() {
	run_test_long $1 $2 &
	pid=$! # Process Id of the previous running command

	spin='-\|/'

	i=0
	sleep 1
	while kill -0 $pid 2>/dev/null
	do
		i=$(( (i+1) %4 ))
	    printf "\033[46;37m \r[${spin:$i:1}] Running\033[0m  "
		sleep .1
	done
	sleep 2
	echo -e "\033[42;37m Brilliant! Test case succeed!\033[0m"

}

echo "Serverless-bench Tests"

# ./app_base_build.sh ../../functionBench/molecule/matmul
pushd ../../forkable-python-runtime/scripts > /dev/null

sudo rm -rf ~/.base/
mkdir -p ~/.base/container0
mkdir -p ~/.base/spin0
mkdir -p ~/.base/baseline

run_test_friendly ImageResize image-resize

popd
