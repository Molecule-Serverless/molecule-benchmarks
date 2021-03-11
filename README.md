# Alexa applications

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



