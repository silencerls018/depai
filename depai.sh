#!/bin/bash

# 一键安装 Depai 脚本（菜单形式）

# 返回主目录
cd ~
mkdir -p depai
cd depai

# 下载并执行安装脚本
echo "Downloading the installation script..."
curl -fsSL -o /tmp/install.sh https://depai.online/downloads/install.sh
echo "Running the installation script..."
source /tmp/install.sh login

# 菜单函数
function show_menu() {
    echo "======================================"
    echo "            Depai Menu               "
    echo "======================================"
    echo "1. 登录"
    echo "2. 创建 Worker"
    echo "3. 初始化 Worker"
    echo "4. 将 Worker 设为在线"
    echo "5. 升级 Depai 客户端"
    echo "6. 退出"
    echo "======================================"
}

# 主循环
while true; do
    show_menu
    read -p "请选择一个选项 (1-6): " option

    case $option in
        1)
            # 登录
            read -p "请输入您的 Depai 登录账户: " login_account
            read -sp "请输入您的密码: " login_password
            echo
            echo "正在登录..."
            depai login $login_account $login_password
            ;;
        2)
            # 创建 Worker
            echo "正在创建 Worker..."
            depai create
            ;;
        3)
            # 初始化 Worker
            echo "正在初始化 Worker..."
            depai init
            ;;
        4)
            # 将 Worker 设为在线
            echo "将 Worker 设为在线..."
            depai online
            ;;
        5)
            # 升级客户端
            echo "正在升级 Depai 客户端..."
            depai upgrade
            ;;
        6)
            # 退出
            echo "退出程序。"
            break
            ;;
        *)
            echo "无效选项，请输入 1-6。"
            ;;
    esac

    # 执行完操作后返回主目录
    cd ~
    cd depai
done
