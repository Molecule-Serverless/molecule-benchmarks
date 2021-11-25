## For ARM env, uncomment the following command
#docker run --rm -it -v $(pwd):/home -v $(pwd)/../molecule-js-env/src:/env --entrypoint=/bin/bash ddnirvana/molecule-js-env:arm-v2

## For x86 env, uncomment the following command
docker run --rm -it -v $(pwd):/home -v $(pwd)/../molecule-js-env/ipc-dag-src:/env -w /env/ --entrypoint=/env/install.sh ddnirvana/molecule-js-env:v3-node14.16.0
