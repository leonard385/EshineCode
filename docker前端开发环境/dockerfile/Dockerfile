FROM ubuntu:14.04 
MAINTAINER “niwanglongDevUbuntu”
#apt-get 换源
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update

#安装linux基本软件
RUN apt-get install -y vim bash-completion

#安装前端开发环境
RUN apt-get install -y npm
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
RUN apt-get install -y curl
RUN npm install -g -y n
RUN n stable
RUN npm install -y --global vue-cli

#开放Vue-Cli端口
EXPOSE 8080

#启动运行指令
CMD ["/bin/bash"]
