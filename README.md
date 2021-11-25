# Molecule benchmarks

This is the repo for molecule benchmarks.

Following contains the detailed instructions to run the tests

## Single-Func

In this case, we will use the single-func runtime to run a single function,
to evaluate each function execution costs.

Used workloads:
- Alexa function chain: we will evaluate the each function of Alexa one-by-one

### Instructions

To build:

	./single-func/docker_build.sh

To run:

	./single-func/docker_run.sh

The script will execute test cases and write data/log to a directory named results/.
The script will run all alexa functions, to run individual, please read the script and comment some cases.





## IPC microbench

IPC的测试环境配置稍微麻烦一点。初步的instructions在wiki页面：https://ipads.se.sjtu.edu.cn:1312/heros/molecule/molecule/-/wikis/workloads%E5%86%85%E5%AE%B9中。

### Introduction

简单来说，测试的是A->B，这个过程中的IPC通信开销。
现在选择的例子是Alexa的frontend call interact的例子。


### Instrucrion

setup相对麻烦一点，需要手动起两个容器，并且进行相关配置。完成配置后调用client的测试脚本去invoke测试。

在molecule-js-env/src/env_frontend.sh中，确认容器2（callee，interact fn）的ip。

	#A-B在同一个机器上时用172.17.0.1，否则就用B所在机器的具体的ip即可
	export INFO_HOST=172.17.0.1


配置容器1 （跑frontend）：

	docker run --rm -it -p 12301:40041 -v PATH-to-molecule-benchmarks/:/home -v PATH-to-molecule-js-env/src/:/env --entrypoint=/bin/bash registry.cn-shanghai.aliyuncs.com/jointfaas-serverless/env-javascript:v6.1
	# 在容器内执行下面的命令
	source ./env_prepare.sh
	source ./env_frontend.sh
	node ./index_ipc_base.js

完成上面操作后，容器1已经配置好了，并且会监听在当前机器上的12301端口。

配置容器2 （跑frontend）：
	docker run --rm -it -p 12302:40041 -v PATH-to-molecule-benchmarks/:/home -v PATH-to-molecule-js-env/src/:/env --entrypoint=/bin/bash registry.cn-shanghai.aliyuncs.com/jointfaas-serverless/env-javascript:v6.1
	# 在容器内执行下面的命令
	source ./env_prepare.sh
	source ./env_interact.sh
	node ./index_ipc_base.js


完成上面操作后，容器2已经配置好了，并且会监听在当前机器上的12302端口。

在A所在的机器上再开一个shell，进入PATH-to-molecule-benchmarks/。

	./test_ipc.sh

上面的命令会调用100次链。
注意，输出结果是直接打印在A、B容器的终端的，如果要输出log文件中，需要把上面的node ./index_ipc_base.js的命令改成：

	node ./index_ipc_base.js > ipc_callee-caller-ddPC7_callee-liu_alexa_interact.log

现在测试程序会记录：A、B的执行时间，A调用B的时间（B的执行时间+IPC RTT的时间）。可以通过这些时间算出IPC的开销。





