#!/bin/bash 

#export BUILD_ID=dontKillMe这一句很重要，这样指定了，项目启动之后才不会被Jenkins杀掉。
export BUILD_ID=dontKillMe

#指定最后编译好的jar存放的位置
www_path=/var/www/obpm/
#obpm_home 文件存放路径
obpm_home = /root/obpm_home/obpm-demo
#Jenkins中编译好的jar位置 、jar名称
jar_path_runtime=/var/jenkins_home/workspace/obpm4.2纯净/obpm-runtime-alone/target/
jar_name_runtime=obpm-runtime-alone-4.2.0.jar
jar_path_designer=/var/jenkins_home/workspace/obpm4.2纯净/obpm-designer/target/
jar_name_designer=obpm-designer-4.2.0.jar

#获取运行编译好的进程ID，便于我们在重新部署项目的时候先杀掉以前的进程
pid1=`ps -ef|grep ${jar_name_runtime}|grep -v grep|awk '{print $2}'`
pid2=`ps -ef|grep ${jar_name_designer}|grep -v grep|awk '{print $2}'`

#杀掉以前可能启动的项目进程
kill -9 ${pid1}  ${pid2}
#进入指定的编译好的jar的位置

#将编译好的jar复制到最后指定的位置
cp  ${jar_path_runtime}/${jar_name_runtime} ${www_path}
cp  ${jar_path_designer}/${jar_name_designer} ${www_path}

#进入最后指定存放jar的位置
cd  ${www_path}

#启动jar，指定SpringBoot的profiles为test,后台启动
nohup java -server -Xms128m -Xmx818m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=512m -jar  ${jar_name_runtime} --server.port=3089 --myapps.storage.root=${obpm_home}   >runtime_log.log  & 
nohup java -jar  ${jar_name_designer} --server.port=3088 --myapps.storage.root=${obpm_home}   >de_log.log  & 
