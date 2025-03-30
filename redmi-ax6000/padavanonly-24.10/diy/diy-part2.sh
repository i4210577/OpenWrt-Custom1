#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
sed -i 's/192.168.6.1/192.168.11.1/g' package/base-files/files/bin/config_generate
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# sed -i 's/luci-app-wrtbwmon//g' target/linux/mediatek/Makefile
# 安装 mosdns
rm -rf feeds/packages/lang/golang
rm -rf feeds/packages/net/mosdns
rm -rf package/feeds/packages/mosdns
rm -rf feeds/packages/net/v2ray-geodata
rm -rf package/feeds/packages/v2ray-geodata
git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

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

gunzip -f "$TEMP_FILE"

if [ ! -f "$UNZIPPED_FILE" ]; then
    echo "解压失败！"
    exit 1
fi

chmod +x "$UNZIPPED_FILE"
mv "$UNZIPPED_FILE" "$CORE_FILE"
chmod +x "$CORE_FILE"
echo "Mihomo 内核已成功下载并配置到 $CORE_FILE"

# 下载 OpenClash GeoIP 数据库
GEOIP_FILE="feeds/luci/applications/luci-app-openclash/root/etc/openclash/GeoIP.dat"
curl -sL --retry 3 --retry-delay 5 -m 30 "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" -o "/tmp/GeoIP.dat"

if [ -s "/tmp/GeoIP.dat" ]; then
    mv -f "/tmp/GeoIP.dat" "$GEOIP_FILE"
    echo "GeoIP 数据库更新成功！"
else
    echo "GeoIP 数据库下载失败！"
fi

# 下载 OpenClash GeoSite 数据库
GEOSITE_FILE="feeds/luci/applications/luci-app-openclash/root/etc/openclash/GeoSite.dat"
curl -sL --retry 3 --retry-delay 5 -m 30 "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat" -o "/tmp/GeoSite.dat"

if [ -s "/tmp/GeoSite.dat" ]; then
    mv -f "/tmp/GeoSite.dat" "$GEOSITE_FILE"
    echo "GeoSite 数据库更新成功！"
else
    echo "GeoSite 数据库下载失败！"
fi

#修复Coremark编译失败
sed -i 's/mkdir/mkdir -p/g' feeds/packages/utils/coremark/Makefile
