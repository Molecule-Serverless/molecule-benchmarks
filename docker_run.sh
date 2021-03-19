docker run --rm -it -v $(pwd):/home -v $(pwd)/../molecule-js-env/src:/env --entrypoint=/bin/bash ddnirvana/molecule-js-env:arm-v2

#docker run --rm -it -v /home/dd/molecule-faas/molecule-benchmarks:/home --entrypoint=/bin/bash registry.cn-shanghai.aliyuncs.com/jointfaas-serverless/env-javascript:v6.1
