#!/usr/bin/env bash
#########################################
## Maven构建、Docker镜像制作、Docker仓库推送
## Author RenFei(i@renfei.net)
## 公网地址：registry.cn-hangzhou.aliyuncs.com/privately/renfei
## 专有网络：registry-vpc.cn-hangzhou.aliyuncs.com/privately/renfei
## 经典网络：registry-internal.cn-hangzhou.aliyuncs.com/privately/renfei
#########################################
PASSWORD=$1
PROJECT_VERSION=$(mvn -Dexec.executable='echo' -Dexec.args='${project.version}' --non-recursive exec:exec -q)
REGISTRY=registry.cn-hangzhou.aliyuncs.com
NAMESPACES=privately
REPOSITORIES=www.renfei.net
#########################################
echo "#########################################"
echo "# RENFEI.NET 编译构建生产环境Docker镜像文件"
echo "# Build Version: $REPOSITORIES:$PROJECT_VERSION"
echo "#########################################"
mvn clean package -Dmaven.test.skip=true -P prod
echo "#########################################"
echo "# Docker 构建开始 >>>>"
echo "#########################################"
docker build -t $REPOSITORIES:"$PROJECT_VERSION" .
IMAGEID=$(docker images -q --filter reference=$REPOSITORIES:"$PROJECT_VERSION")
echo "构建完成 >>>> IMAGE ID:$IMAGEID"
echo "#########################################"
echo "# 请登陆 Docker 仓库 >>>>"
echo "#########################################"
if [ "$PASSWORD" != "" ]; then
  docker login --username=i@renfei.net --password="$PASSWORD" $REGISTRY
else
  docker login --username=i@renfei.net $REGISTRY
fi
docker tag "$IMAGEID" $REGISTRY/$NAMESPACES/$REPOSITORIES:"$PROJECT_VERSION"
echo "#########################################"
echo "# 开始推送 Docker 镜像到仓库 >>>>"
echo "#########################################"
docker push $REGISTRY/$NAMESPACES/$REPOSITORIES:"$PROJECT_VERSION"
echo "#########################################"
echo "# 删除本地 Docker 镜像到仓库 >>>>"
echo "#########################################"
docker rmi "$IMAGEID"
echo "#########################################"
echo "# 全部构建完成！ Version: $REPOSITORIES:$PROJECT_VERSION"
echo "# 镜像地址: $REGISTRY/$NAMESPACES/$REPOSITORIES:$PROJECT_VERSION"
echo "# 镜像地址: registry-vpc.cn-hangzhou.aliyuncs.com/$NAMESPACES/$REPOSITORIES:$PROJECT_VERSION"
echo "#########################################"
