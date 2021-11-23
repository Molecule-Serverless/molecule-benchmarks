# FROM val01:5000/python-base-image:dev-base
FROM ddnirvana/python-base-image:dev-base-3.6
RUN mkdir -p /code/gzip_app
RUN mkdir -p /code/anti_money_app

COPY gzip_app/func_invoker /code/gzip_app/
COPY gzip_app/fpga_func.awsxclbin /code/gzip_app/

