#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
## 修改DTS的ubi为490MB的0x1ea00000
#sed -i 's/reg = <0x600000 0x6e00000>/reg = <0x600000 0x1ea00000>/' target/linux/mediatek/files-5.4/arch/arm64/boot/dts/mediatek/mt7986a-xiaomi-redmi-router-ax6000.dts
sed -i '$a src-git nikki https://github.com/nikkinikki-org/OpenWrt-nikki.git;main' feeds.conf.default

# mosdns
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/luci-app-mosdns
# OpenClash
#git clone https://github.com/vernesong/OpenClash package/luci-app-openclash
# adguardhome
#git clone https://github.com/SuperArilo/luci-app-adguardhome.git package/luci-app-adguardhome
# 网络唤醒
git clone https://github.com/Firsgith/luci-app-wolplus.git package/luci-app-wolplus
# lucky
git clone https://github.com/sirpdboy/luci-app-lucky package/lucky
# 进阶设置
git clone https://github.com/sirpdboy/luci-app-advancedplus package/luci-app-advancedplus
#git clone https://github.com/sirpdboy/luci-app-advanced package/luci-app-advanced
# vnt组网
git clone https://github.com/lmq8267/luci-app-vnt.git package/vnt
# 定时设置
git clone https://github.com/sirpdboy/luci-app-autotimeset package/luci-app-autotimeset
# 安装tailscale组网
sed -i '/\/etc\/init\.d\/tailscale/d;/\/etc\/config\/tailscale/d;' feeds/packages/net/tailscale/Makefile
git clone https://github.com/asvow/luci-app-tailscale package/luci-app-tailscale
# Theme
git clone https://github.com/SAENE/luci-theme-design package/luci-theme-design
# DNS助手
git clone https://github.com/kongfl888/openwrt-my-dnshelper package/openwrt-my-dnshelper
# ddns-go
git clone https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go
# 关机功能
git clone https://github.com/sirpdboy/luci-app-poweroffdevice package/luci-app-poweroffde
