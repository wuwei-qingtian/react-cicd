#!/bin/bash
WORK_PATH='/home/jenkins/workspace/react-cicd'
cd $WORK_PATH
echo "清理代码"
git reset --hard origin/master
git clean -f
echo "拉取最新代码"
git pull origin master
echo "打包最新代码"
npm install
echo "安装依赖成功"
npm run build
echo "删除原镜像"
docker rmi -f react-front:1.0
echo "删除旧容器"
docker stop react-front-container
docker rm react-front-container
echo "开始构建镜像"
docker build -t react-front:1.0 .
echo "登录阿里云镜像"
docker login --username=yyou1995 --password=yyou1995. registry.cn-hangzhou.aliyuncs.com
docker tag react-front:1.0 registry.cn-hangzhou.aliyuncs.com/aliyun-cicd/jenkins-demo:0.0.1
docker push registry.cn-hangzhou.aliyuncs.com/aliyun-cicd/jenkins-demo:0.0.1
echo "拉取阿里云镜像"
docker rmi -f registry.cn-hangzhou.aliyuncs.com/aliyun-cicd/jenkins-demo:0.0.1
docker pull registry.cn-hangzhou.aliyuncs.com/aliyun-cicd/jenkins-demo:0.0.1
echo "启动新容器"
docker run -d -p 80:80 --name react-front-container registry.cn-hangzhou.aliyuncs.com/aliyun-cicd/jenkins-demo:0.0.1


