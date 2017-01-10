#说明 
该Dockerfile建立了基于ubuntu系统，前端基本开发环境。

##使用说明

`docker build -t develop:latest .`

'.'代表 Dockerfile 所在目录

##端口映射

`-p 8080:8080 -v 本地目录绝对路径：/web`