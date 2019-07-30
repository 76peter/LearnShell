#!/bin/bash

#我的安装java设置过全局了不需要这些
#export JAVA_HOME=/root/tools/jdk1.8.0_181
#export JRE_HOME=/$JAVA_HOME/jre
#export CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
#export PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin

#这里可替换为你自己的执行程序，其他代码无需更改
Myapp=/opt/haloboke/halo-latest.jar
myappname=halo-latest
var1=$1

#使用说明，用来提示输入参数
usage() {
    echo "使用说明: 请输入 start|stop|restart|status "
	read var1
    echo "var1 = $var1"
	switch
}

#检查程序是否在运行
is_exist(){
  pid=`ps -ef|grep $myappname|grep -v grep|awk '{print $2}'`
  #如果不存在返回1，存在返回0     
  if [ -z "${pid}" ]; then
   return 1
  else
    return 0
  fi
}

#启动方法
start(){
  is_exist
  if [ $? -eq 0 ]; then
    echo "${Myapp} is already running. pid=${pid}"
  else
    nohup java -jar ${Myapp}  >MyappConsole.out 2>&1 &
  fi
}

#停止方法
stop(){
  is_exist
  if [ $? -eq "0" ]; then
    kill -9 $pid
  else
    echo "${Myapp} is not running"
  fi  
}

#输出运行状态
status(){
  is_exist
  if [ $? -eq "0" ]; then
    echo "${Myapp} is running. Pid is ${pid}"
  else
    echo "${Myapp} is NOT running."
  fi
}

#重启
restart(){
  stop
  sleep 5
  start
}

#根据输入参数，选择执行对应方法，不输入则执行使用说明
switch(){
	case "$var1" in
	  "start")
		start
		;;
	  "stop")
		stop
		;;
	  "status")
		status
		;;
	  "restart")
		restart
		;;
	  *)
		usage
		;;
	esac
}

switch