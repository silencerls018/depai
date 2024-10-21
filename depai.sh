#!/bin/bash

# 一键安装 Depai 脚本（菜单形式）

# 返回主目录
cd ~
mkdir -p depai
cd depai

# 下载并执行安装脚本
echo "Downloading the installation script..."
if ! curl -fsSL -o /tmp/install.sh https://depai.online/downloads/install.sh; then
    echo "下载安装脚本失败！请检查网络连接或 URL 是否正确。"
    exit 1
fi

echo "Running the installation script..."
if ! source /tmp/install.sh login; then
    echo "运行安装脚本失败！"
    exit 1
fi

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
            if ! depai login "$login_account" "$login_password"; then
                echo "登录失败，请检查您的账户和密码。"
            fi
            ;;
        2)
            # 创建 Worker
            echo "正在创建 Worker..."
            if ! depai create; then
                echo "创建 Worker 失败！"
            fi
            ;;
        3)
            # 初始化 Worker
            echo "正在初始化 Worker..."
            if ! depai init; then
                echo "初始化 Worker 失败！"
            fi
            ;;
        4)
            # 将 Worker 设为在线
            echo "将 Worker 设为在线..."
            if ! depai online; then
                echo "设置 Worker 为在线失败！"
            fi
            ;;
        5)
            # 升级客户端
            echo "正在升级 Depai 客户端..."
            if ! depai upgrade; then
                echo "升级 Depai 客户端失败！"
            fi
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
