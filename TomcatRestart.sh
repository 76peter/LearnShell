#!/bin/sh
#==================================
#author by lizhongnian
#2019年6月5日
#将此脚本放入tomcat下的bin目录下
#==================================

#定义要处理的tomcat路径
TomcatPath=$(dirname $(dirname $(readlink -f "$0")))
##定义常用属性
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[信息]${Font_color_suffix}"
Error="${Red_font_prefix}[错误]${Font_color_suffix}"
Tip="${Green_font_prefix}[注意]${Font_color_suffix}"
if [ -z "$TomcatPath" ];then
        echo -e "${Error}：获取到的路径为空！"
        exit
else
        echo "${Info}：你的tomcat路径为：$TomcatPath"
fi

#获取对应tomcat PID
unset pid
pid=$(ps -ef | grep $TomcatPath | grep java | grep -v grep | awk '{print $2}')

#判断是否有正在运行的tomcat进程
if [ ! -n "$pid" ] ; 
then 
echo -e "${Error}：获取pid失败，退出执行"
exit 
else
echo -e "${Info} pid=${pid}"
fi 
#确认有对应的tomcat进程，先进入tomcat的bin目录，使用shutdown停止任务
bash $TomcatPath/bin/shutdown.sh
#等待3s
echo -e "${Info}:执行shutdown，等待3s后继续" 
sleep 3
#第二次检测是否有正在运行的tomcat进程
unset pidTwo
pidTwo=$(ps -ef | grep $TomcatPath | grep java | grep -v grep | awk '{print $2}')
if [ ! -n "$pidTwo" ] ;  
then 
echo -e "${Info}：使用shutdown停止任务成功" 
else
echo -e "${Error}：使用shutdown停止任务失败，即将kill tomcat进程"

length=${echo $pidTwo | awk '{ print $2; }'}
if [ "$length" != "" ];then
        echo "获取到多个pid，退出执行"
        exit
else
        kill -9 $pidTwo
		echo -e "${Info}:tomcat进程停止成功" 
fi
fi 

logs_path=$TomcatPath/logs/
current_path="$PWD"
cd $logs_path
if [ -e catalina.out ];then
        rm -rf *
else
        echo "${Tip}:日志已经为空了"
fi
echo -e "${Info}:日志目录清理成功！" 

work_path=$TomcatPath/work/
current_path="$PWD"
cd $work_path
if [ -e Catalina ];then
        rm -rf *
else
        echo "${Tip}:Catalina已经为空了"
fi

echo -e "${Info}:Catalina目录清理成功！" 
cd $current_path
echo -e "${Info}:正在执行启动！" 
bash $TomcatPath/bin/startup.sh
pidNew=$(ps -ef | grep $TomcatPath | grep java | grep -v grep | awk '{print $2}')
echo -e "${Info}:启动成功，重启之后的tomcat进程号为$pidNew" 
stty erase '^H' && read -p " 是否直接打印日志(yes/y：继续；no/n：退出；回车默认打印):" status
case "$status" in
	yes|y)
	echo -e "${Info} 您选择了打印日志！"
	tail -f $TomcatPath/logs/catalina.out 
	;;
	no|n)
	echo -e "${Tip} 您选择了不打印日志！" && exit 1
	;;
	*)
	echo -e "${Info} 您选择了打印日志！"
	tail -f $TomcatPath/logs/catalina.out 
	;;
esac