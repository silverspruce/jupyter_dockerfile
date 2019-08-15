FROM silverspruce/keras_image:latest

#国内使用本机文件替换
#COPY sources.list /etc/apt/

# graphviz是pydot配套绘图包
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      graphviz \
    && rm -rf /var/lib/apt/lists/* 

# conda安装前端及绘图包
RUN conda install -y \
      pydot \
      jupyter \
      matplotlib \
      seaborn

# 匿名挂载卷 防止容器运行中向容器存储层写入数据，通过docker run中-v参数，可以将匿名卷挂载到宿主机上
VOLUME /notebook

# 设置启动工作路径
WORKDIR /notebook

# 默认暴露端口，可以在docker run中通过-p参数覆盖
EXPOSE 8888

# 启动进程命令，执行后容器就像一个宿主机上的进程,在子镜像中可以被覆盖
CMD jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token= --NotebookApp.allow_origin='*'

