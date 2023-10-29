#!/bin/bash

endpointyx(){    
    # 取消 Linux 自带的线程限制，以便生成优选 Endpoint IP
    ulimit -n 102400
    # 启动 WARP Endpoint IP 优选工具
    chmod +x warp && ./warp-linux-amd64
    cp result.csv /mnt/sda3/warp 
    "Endpoint IP 结果已保存至 result.csv中："
}

endpointyx

python3 WireguardConfig.py

# docker run -it --rm --name my-running-script -v /mnt/sda3/warp:/usr/src/myapp -w /usr/src/myapp python:3 python WireguardConfig.py

# cp warp.yaml /etc/openclash/config

# /etc/init.d/openclash restart 2>/dev/null
