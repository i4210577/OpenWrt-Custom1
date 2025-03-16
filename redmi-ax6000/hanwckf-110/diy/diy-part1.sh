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
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# Theme
#git clone https://github.com/SAENE/luci-theme-design package/luci-theme-design

# luci-app-adguardhome
git clone https://github.com/xiaoxiao29/luci-app-adguardhome package/luci-app-adguardhome

# 安装 mosdns
#rm -rf feeds/packages/lang/golang
#rm -rf feeds/packages/net/mosdns
#rm -rf package/feeds/packages/mosdns
#rm -rf feeds/packages/net/v2ray-geodata
#rm -rf package/feeds/packages/v2ray-geodata
#git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang
#git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
#git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# 获取隔空播放luci-app-airconnect
#git clone https://github.com/sbwml/luci-app-airconnect package/airconnect

# OpenClash
#git clone --depth 1 https://github.com/vernesong/openclash.git OpenClash
#rm -rf feeds/luci/applications/luci-app-openclash
#mv OpenClash/luci-app-openclash feeds/luci/applications/luci-app-openclash
git clone https://github.com/vernesong/OpenClash package/luci-app-openclash

# luci-app-tailscale
#sed -i '/\/etc\/init\.d\/tailscale/d;/\/etc\/config\/tailscale/d;' feeds/packages/net/tailscale/Makefile
#git clone https://github.com/asvow/luci-app-tailscale package/luci-app-tailscale

# lucky
git clone https://github.com/sirpdboy/luci-app-lucky package/lucky

# 一键配置拨号
# git clone https://github.com/caiweill/luci-app-netwizard package/luci-app-netwizard

# 进阶设置
git clone https://github.com/sirpdboy/luci-app-advancedplus package/luci-app-advancedplus

# 系统高级设置
git clone https://github.com/sirpdboy/luci-app-advanced package/luci-app-advanced

# 定时设置
git clone https://github.com/sirpdboy/luci-app-autotimeset package/luci-app-autotimeset

# 获取隔空播放
git clone https://github.com/sbwml/luci-app-airconnect package/airconnect

# ddns-go
git clone https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go

# 关机功能
git clone https://github.com/sirpdboy/luci-app-poweroffdevice package/luci-app-poweroffde

# 设置向导
git clone https://github.com/sirpdboy/luci-app-netwizard package/luci-app-netwizard

# 分区扩容
git clone https://github.com/sirpdboy/luci-app-partexp.git package/luci-app-partexp
