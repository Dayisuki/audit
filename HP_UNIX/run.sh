#! /bin/sh
if [ ! $UID = 0 ] && [ "$1" = "xml" ];then
echo -e "\033[31m请用高级权限运行\033[0m"
echo "权限不足将导致检测内容不全"
read -p "继续请回车,建议请ctrl-c退出后执行sudo -i提升权限后再执行此脚本" tmp
fi

pathname=`pwd`
case $1 in
    xml)
        perl $pathname/run.pl
        ;;
    excel)
        python3 run.py
        ;;
    *)
        echo "用法: ./run.sh {xml|excel}"
        ;;
esac
