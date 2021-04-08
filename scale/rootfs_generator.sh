echo This is the rootfs generator
echo The image your want to generate is: $1

rm rootfs -rf
mkdir rootfs

docker export $(docker create $1) | tar -C rootfs -xvf -

