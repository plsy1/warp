#!/bin/bash

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
PLAIN='\033[0m'

red() {
    echo -e "\033[31m\033[01m$1\033[0m"
}

green() {
    echo -e "\033[32m\033[01m$1\033[0m"
}

yellow() {
    echo -e "\033[33m\033[01m$1\033[0m"
}

# 选择客户端 CPU 架构
archAffix(){
    case "$(uname -m)" in
        i386 | i686 ) echo '386' ;;
        x86_64 | amd64 ) echo 'amd64' ;;
        armv8 | arm64 | aarch64 ) echo 'arm64' ;;
        s390x ) echo 's390x' ;;
        * ) red "不支持的CPU架构!" && exit 1 ;;
    esac
}

endpointyx(){    
    # 下载优选工具软件，感谢某匿名网友的分享的优选工具
    wget https://gitlab.com/Misaka-blog/warp-script/-/raw/main/files/warp-yxip/warp-linux-$(archAffix) -O warp
    
    # 取消 Linux 自带的线程限制，以便生成优选 Endpoint IP
    ulimit -n 102400
    
    # 启动 WARP Endpoint IP 优选工具
    chmod +x warp && ./warp >/dev/null 2>&1
    
    # 显示前十个优选 Endpoint IP 及使用方法
    green "当前最优 Endpoint IP 结果如下，并已保存至 result.csv中："
    cat result.csv | awk -F, '$3!="timeout ms" {print} ' | sort -t, -nk2 -nk3 | uniq | head -11 | awk -F, '{print "端点 "$1" 丢包率 "$2" 平均延迟 "$3}'
    echo ""
    yellow "使用方法如下："
    yellow "1. 将 WireGuard 节点的默认的 Endpoint IP：engage.cloudflareclient.com:2408 替换成本地网络最优的 Endpoint IP"

    # 删除 WARP Endpoint IP 优选工具及其附属文件
    rm -f warp ip.txt
}

endpoint4(){
    # 生成优选 WARP IPv4 Endpoint IP 段列表
    n=0
    iplist=100
    while true; do
        temp[$n]=$(echo 162.159.192.$(($RANDOM % 256)))
        n=$(($n + 1))
        if [ $n -ge $iplist ]; then
            break
        fi
        temp[$n]=$(echo 162.159.193.$(($RANDOM % 256)))
        n=$(($n + 1))
        if [ $n -ge $iplist ]; then
            break
        fi
        temp[$n]=$(echo 162.159.195.$(($RANDOM % 256)))
        n=$(($n + 1))
        if [ $n -ge $iplist ]; then
            break
        fi
        temp[$n]=$(echo 162.159.204.$(($RANDOM % 256)))
        n=$(($n + 1))
        if [ $n -ge $iplist ]; then
            break
        fi
        temp[$n]=$(echo 188.114.96.$(($RANDOM % 256)))
        n=$(($n + 1))
        if [ $n -ge $iplist ]; then
            break
        fi
        temp[$n]=$(echo 188.114.97.$(($RANDOM % 256)))
        n=$(($n + 1))
        if [ $n -ge $iplist ]; then
            break
        fi
        temp[$n]=$(echo 188.114.98.$(($RANDOM % 256)))
        n=$(($n + 1))
        if [ $n -ge $iplist ]; then
            break
        fi
        temp[$n]=$(echo 188.114.99.$(($RANDOM % 256)))
        n=$(($n + 1))
        if [ $n -ge $iplist ]; then
            break
        fi
    done
    while true; do
        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]; then
            break
        else
            temp[$n]=$(echo 162.159.192.$(($RANDOM % 256)))
            n=$(($n + 1))
        fi
        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]; then
            break
        else
            temp[$n]=$(echo 162.159.193.$(($RANDOM % 256)))
            n=$(($n + 1))
        fi
        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]; then
            break
        else
            temp[$n]=$(echo 162.159.195.$(($RANDOM % 256)))
            n=$(($n + 1))
        fi
        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]; then
            break
        else
            temp[$n]=$(echo 162.159.204.$(($RANDOM % 256)))
            n=$(($n + 1))
        fi
        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]; then
            break
        else
            temp[$n]=$(echo 188.114.96.$(($RANDOM % 256)))
            n=$(($n + 1))
        fi
        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]; then
            break
        else
            temp[$n]=$(echo 188.114.97.$(($RANDOM % 256)))
            n=$(($n + 1))
        fi
        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]; then
            break
        else
            temp[$n]=$(echo 188.114.98.$(($RANDOM % 256)))
            n=$(($n + 1))
        fi
        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]; then
            break
        else
            temp[$n]=$(echo 188.114.99.$(($RANDOM % 256)))
            n=$(($n + 1))
        fi
    done

    # 将生成的 IP 段列表放到 ip.txt 里，待程序优选
    echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u > ip.txt

    # 启动优选程序
    endpointyx
}

endpoint6(){
    # 生成优选 WARP IPv6 Endpoint IP 段列表
    n=0
    iplist=100
    while true; do
        temp[$n]=$(echo [2606:4700:d0::$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2)))])
        n=$(($n + 1))
        if [ $n -ge $iplist ]; then
            break
        fi
        temp[$n]=$(echo [2606:4700:d1::$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2)))])
        n=$(($n + 1))
        if [ $n -ge $iplist ]; then
            break
        fi
    done
    while true; do
        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]; then
            break
        else
            temp[$n]=$(echo [2606:4700:d0::$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2)))])
            n=$(($n + 1))
        fi
        if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]; then
            break
        else
            temp[$n]=$(echo [2606:4700:d1::$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2))):$(printf '%x\n' $(($RANDOM * 2 + $RANDOM % 2)))])
            n=$(($n + 1))
        fi
    done

    # 将生成的 IP 段列表放到 ip.txt 里，待程序优选
    echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u > ip.txt

    # 启动优选程序
    endpointyx
}

menu(){
    clear
    echo "#############################################################"
    echo -e "#               ${RED}WARP Endpoint IP 一键优选脚本${PLAIN}               #"
    echo -e "# ${GREEN}作者${PLAIN}: MisakaNo の 小破站                                  #"
    echo -e "# ${GREEN}博客${PLAIN}: https://blog.misaka.rest                            #"
    echo -e "# ${GREEN}GitHub 项目${PLAIN}: https://github.com/Misaka-blog               #"
    echo -e "# ${GREEN}GitLab 项目${PLAIN}: https://gitlab.com/Misaka-blog               #"
    echo -e "# ${GREEN}Telegram 频道${PLAIN}: https://t.me/misakanocchannel              #"
    echo -e "# ${GREEN}Telegram 群组${PLAIN}: https://t.me/misakanoc                     #"
    echo -e "# ${GREEN}YouTube 频道${PLAIN}: https://www.youtube.com/@misaka-blog        #"
    echo "#############################################################"
    echo ""
    echo -e " ${GREEN}1.${PLAIN} WARP IPv4 Endpoint IP 优选 ${YELLOW}(默认)${PLAIN}"
    echo -e " ${GREEN}2.${PLAIN} WARP IPv6 Endpoint IP 优选"
    echo " -------------"
    echo -e " ${GREEN}0.${PLAIN} 退出脚本"
    echo ""
    read -rp "请输入选项 [0-2]: " menuInput
    case $menuInput in
        2 ) endpoint6 ;;
        0 ) exit 1 ;;
        * ) endpoint4 ;;
    esac
}

menu