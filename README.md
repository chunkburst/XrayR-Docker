# XrayR-Docker
实现在Docker容器内部一键守护进程启动XrayR



### 🔧 作用是什么?

帮助你在某些极端环境下（例如Docker容器虚拟化 + 128MB内存的VPS中）成功使用XrayR

如果是普通环境下，请使用官方脚本： [XrayR-project/XrayR](https://github.com/XrayR-project/XrayR)

它与官方脚本的差别?

- Docker虚拟化中的容器能用（官方的脚本目前似乎不能用）
- 超迷你款（只要约200MB硬盘空间即可运行，官方脚本需至少500MB）



### 📦 快速安装

```bash
wget -q -N --no-check-certificate https://raw.githubusercontent.com/chunkburst/XrayR-Docker/main/src/install.sh && chmod +x install.sh && ./install.sh
```



### 🌐 FAQ

>  Q：它好用吗?

- A：不知道

>  Q：它保证不挂吗?

- A：不知道

>  Q：性能有损失吗?

- A：不知道
