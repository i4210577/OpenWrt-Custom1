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
#git clone https://github.com/sirpdboy/luci-app-autotimeset package/luci-app-autotimeset
# 安装tailscale组网
sed -i '/\/etc\/init\.d\/tailscale/d;/\/etc\/config\/tailscale/d;' feeds/packages/net/tailscale/Makefile
git clone https://github.com/asvow/luci-app-tailscale package/luci-app-tailscale
# Theme
#git clone https://github.com/SAENE/luci-theme-design package/luci-theme-design

# 安装 OpenClash
git clone --depth 1 https://github.com/vernesong/openclash.git OpenClash
rm -rf feeds/luci/applications/luci-app-openclash
mv OpenClash/luci-app-openclash feeds/luci/applications/luci-app-openclash

CORE_DIR="feeds/luci/applications/luci-app-openclash/root/etc/openclash/core"
CORE_FILE="$CORE_DIR/clash_meta"
TEMP_FILE="/tmp/clash-meta.gz"
UNZIPPED_FILE="/tmp/clash-meta"

mkdir -p "$CORE_DIR"

# 获取最新 Mihomo 版本
LATEST_VERSION=$(curl -sL https://api.github.com/repos/MetaCubeX/mihomo/releases/latest | grep '"tag_name"' | cut -d '"' -f 4)
DOWNLOAD_URL="https://github.com/MetaCubeX/mihomo/releases/download/$LATEST_VERSION/mihomo-linux-arm64-$LATEST_VERSION.gz"

# 下载 Mihomo 内核
echo "正在下载 Mihomo 内核：$LATEST_VERSION"
curl -sL --retry 3 --retry-delay 5 -m 30 "$DOWNLOAD_URL" -o "$TEMP_FILE"

if [ ! -s "$TEMP_FILE" ]; then
    echo "Mihomo 内核下载失败！"
    exit 1
fi

if [ ! -f "$UNZIPPED_FILE" ]; then
    echo "解压失败！"
    exit 1
fi

chmod +x "$UNZIPPED_FILE"
mv "$UNZIPPED_FILE" "$CORE_FILE"
chmod +x "$CORE_FILE"
echo "Mihomo 内核已成功下载并配置到 $CORE_FILE"

# 下载 OpenClash GeoIP 数据库
#GEOIP_FILE="feeds/luci/applications/luci-app-openclash/root/etc/openclash/GeoIP.dat"
#curl -sL --retry 3 --retry-delay 5 -m 30 "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" -o "/tmp/GeoIP.dat"

#if [ -s "/tmp/GeoIP.dat" ]; then
#    mv -f "/tmp/GeoIP.dat" "$GEOIP_FILE"
#    echo "GeoIP 数据库更新成功！"
#else
#    echo "GeoIP 数据库下载失败！"
#fi

# 下载 OpenClash GeoSite 数据库
#GEOSITE_FILE="feeds/luci/applications/luci-app-openclash/root/etc/openclash/GeoSite.dat"
#curl -sL --retry 3 --retry-delay 5 -m 30 "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat" -o "/tmp/GeoSite.dat"

#if [ -s "/tmp/GeoSite.dat" ]; then
#    mv -f "/tmp/GeoSite.dat" "$GEOSITE_FILE"
#    echo "GeoSite 数据库更新成功！"
#else
#    echo "GeoSite 数据库下载失败！"
#fi

#修复Coremark编译失败
sed -i 's/mkdir/mkdir -p/g' feeds/packages/utils/coremark/Makefile
