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

git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/luci-app-mosdns
#git clone https://github.com/vernesong/OpenClash package/luci-app-openclash
#git clone https://github.com/SuperArilo/luci-app-adguardhome.git package/luci-app-adguardhome
git clone https://github.com/Firsgith/luci-app-wolplus.git package/luci-app-wolplus
git clone https://github.com/sirpdboy/luci-app-lucky package/lucky
git clone https://github.com/sirpdboy/luci-app-advancedplus package/luci-app-advancedplus
#git clone https://github.com/sirpdboy/luci-app-advanced package/luci-app-advanced
git clone https://github.com/lmq8267/luci-app-vnt.git package/vnt
#git clone https://github.com/caiweill/luci-app-netwizard package/luci-app-netwizard
#git clone https://github.com/sirpdboy/luci-app-autotimeset package/luci-app-autotimeset
# 安装tailscale组网
sed -i '/\/etc\/init\.d\/tailscale/d;/\/etc\/config\/tailscale/d;' feeds/packages/net/tailscale/Makefile
git clone https://github.com/asvow/luci-app-tailscale package/luci-app-tailscale

# 安装 OpenClash
git clone --depth 1 https://github.com/vernesong/openclash.git OpenClash
rm -rf feeds/luci/applications/luci-app-openclash
mv OpenClash/luci-app-openclash feeds/luci/applications/luci-app-openclash

# OpenClash Mihomo内核
CORE_DIR="feeds/luci/applications/luci-app-openclash/root/etc/openclash/core"
CORE_FILE="$CORE_DIR/clash_meta"
TEMP_FILE="/tmp/clash-meta.gz"
UNZIPPED_FILE="/tmp/clash-meta"

mkdir -p "$CORE_DIR"
curl -sL -m 30 --retry 2 \
    "https://github.com/MetaCubeX/mihomo/releases/download/v1.18.8/mihomo-linux-arm64-v1.18.8.gz" \
    -o "$TEMP_FILE"
gunzip -f "$TEMP_FILE"
chmod +x "$UNZIPPED_FILE"
mv "$UNZIPPED_FILE" "$CORE_FILE"
chmod +x "$CORE_FILE"
echo "Mihomo 内核已成功下载并配置到 $CORE_FILE"

#修复Coremark编译失败
sed -i 's/mkdir/mkdir -p/g' feeds/packages/utils/coremark/Makefile

# OpenClash GeoIP 数据库
curl -sL -m 30 --retry 2 https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat -o /tmp/GeoIP.dat
mv /tmp/GeoIP.dat feeds/luci/applications/luci-app-openclash/root/etc/openclash/GeoIP.dat >/dev/null 2>&1

# OpenClash GeoSite 数据库
curl -sL -m 30 --retry 2 https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat -o /tmp/GeoSite.dat
mv -f /tmp/GeoSite.dat feeds/luci/applications/luci-app-openclash/root/etc/openclash/GeoSite.dat >/dev/null 2>&1
