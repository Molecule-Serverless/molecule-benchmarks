# Molecule benchmarks

This is the repo for molecule benchmarks.

It contains:
- single-func bench: evaluate single func execution costs
- ipc: evaluate IPC performance between two fn



Following contains the detailed instructions to run the tests

## Single-Func

In this case, we will use the single-func runtime to run a single function, to evaluate each function execution costs.

Currently supported apps:
- alexa.

### Instructions

1. Download the molecule-benchmarks and js-env

	git clone https://ipads.se.sjtu.edu.cn:1312/heros/molecule/molecule-benchmarks.git
	git clone https://ipads.se.sjtu.edu.cn:1312/heros/molecule/molecule-js-env.git
	# checkout to single-func branch in molecule-js-env
	cd molecule-js-env && git checkout single-func && cd ..

We use the name, *home-dir*, to represent the directory containing molecule-benchmarks and molecule-js-env.

2. Preparation

	cd home-dir/molecule-js-env
	# download proto
	git submodule update --init --recursive

3. Check docker_run.sh scripts

for x86 env, the scirpt should be:

	docker run --rm -it -v /home/dd/molecule-faas/molecule-benchmarks:/home --entrypoint=/bin/bash registry.cn-shanghai.aliyuncs.com/jointfaas-serverless/env-javascript:v6.1

for arm env, the script should be:

	docker run --rm -it -v $(pwd):/home -v $(pwd)/../molecule-js-env/src:/env --entrypoint=/bin/bash ddnirvana/molecule-js-env:arm-v2


4. Run single-func tests

	# in molecule-bench dir, enter the docker env
	./docker_run.sh

	#in the /env dir, if the node_modules is empty, execute the following instructiosn
	#it happens for 1st installation
	npm install

	# in /env in the docker environment
	./test_single_func_exec.sh

The script will execute test cases and write data/log to a directory named results/.

The script will run all alexa functions, to run individual, please read the script and comment some cases.





## IPC microbench

TODO


## Old REAMDE
Alexa applications

The test case is from ServerlessBench.


## Upload and invoke functions

	git clone https://ipads.se.sjtu.edu.cn:1312/heros/alexa-application.git

	# 首先将多个zip包搞到一个文件夹下
	cd alexa-application/

	# 创建多个function和application，脚本为使用curl创建多个函数并创建一个application
	./hcloud_alexa_test.sh

	# 之后便可以在Manager等环境齐全的情况下invoke了
	./invoke.sh

	# 这个invoke如果失败，可以log看一下mosn。如果mosn报错，直接docker restart一下即可，再invoke就行。这个错误是未知的，等待debug。


## Prepare and generate function package

The source code of each alexa functions is located in src/.

In each directory, you can simply:

	# E.g., to generate frontend
	cd frontend
	zip -r frontend.zip ./*


The generated zip package can be delivered, uploaded to the serverless platform, and be invoked.



