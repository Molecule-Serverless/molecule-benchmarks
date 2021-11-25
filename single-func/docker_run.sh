## For ARM env, uncomment the following command
#docker run --rm -it -v $(pwd):/home -v $(pwd)/../molecule-js-env/src:/env --entrypoint=/bin/bash ddnirvana/molecule-js-env:arm-v2

## For x86 env, uncomment the following command
docker run --rm -it -v $(pwd):/home -v $(pwd)/../molecule-js-env/single-func-src:/env -w /env/ --entrypoint=/env/test_single_func_exec.sh ddnirvana/hclouid-env-javascript:v6.1
