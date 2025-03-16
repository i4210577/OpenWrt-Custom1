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

sed -i 's/192.168.1.1/192.168.11.1/g' package/base-files/files/bin/config_generate
# 修改名称
#sed -i "s/hostname='.*'/hostname='AX6000'/g" package/base-files/files/bin/config_generate
# 修改 WiFi
#sed -i "s/ImmortalWrt-2.4G/Ax6000-2.4G/g" package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
#sed -i "s/ImmortalWrt-5G/Ax6000-5G/g" package/mtk/applications/mtwifi-cfg/files/mtwifi.sh

# ttyd自动登录
#sed -i "s?/bin/login?/usr/libexec/login.sh?g" feeds/packages/utils/ttyd/files/ttyd.config



# 更改菜单名字
#echo -e "\nmsgid \"OpenClash\"" >> feeds/luci/applications/luci-app-openclash/po/zh-cn/openclash.zh-cn.po
#echo -e "msgstr \"科学上网\"" >> feeds/luci/applications/luci-app-openclash/po/zh-cn/openclash.zh-cn.po

#echo -e "\nmsgid \"MosDNS\"" >> package/mosdns/luci-app-mosdns/po/zh_Hans/mosdns.po
#echo -e "msgstr \"域名分流\"" >> package/mosdns/luci-app-mosdns/po/zh_Hans/mosdns.po

#echo -e "\nmsgid \"UPnP\"" >> feeds/luci/applications/luci-app-upnp/po/zh_Hans/upnp.po
#echo -e "msgstr \"即插即用\"" >> feeds/luci/applications/luci-app-upnp/po/zh_Hans/upnp.po

#echo -e "\nmsgid \"Internet Access Schedule Control\"" >> feeds/luci/applications/luci-app-accesscontrol/po/zh_Hans/mia.po
#echo -e "msgstr \"上网时间\"" >> feeds/luci/applications/luci-app-accesscontrol/po/zh_Hans/mia.po

#echo -e "\nmsgid \"Lucky\"" >> package/lucky/luci-app-lucky/po/zh_Hans/lucky.po
#echo -e "msgstr \"大吉大利\"" >> package/lucky/luci-app-lucky/po/zh_Hans/lucky.po

# 软件包与配置

# 主题
#echo "CONFIG_PACKAGE_luci-theme-design=y" >> .config
# 终端
#echo "CONFIG_PACKAGE_luci-app-ttyd=y" >> .config
# 释放内存
#echo "CONFIG_PACKAGE_luci-app-ramfree=y" >> .config
# 网络向导
#echo "CONFIG_PACKAGE_luci-app-netwizard=y" >> .config
# 上网时间控制 应用过滤 网络唤醒 定时设置 网络限速
#echo "CONFIG_PACKAGE_luci-app-accesscontrol=y" >> .config
#echo "CONFIG_PACKAGE_luci-app-appfilter=y" >> .config
#echo "CONFIG_PACKAGE_luci-app-wol=y" >> .config
#echo "CONFIG_PACKAGE_luci-app-autotimeset=y" >> .config
#echo "CONFIG_PACKAGE_luci-app-eqos-mtk=y" >> .config
# 多拨插件 负载均衡
#echo "CONFIG_PACKAGE_luci-app-syncdial=y" >> .config
#echo "CONFIG_PACKAGE_luci-app-mwan3=y" >> .config
# 转播
#echo "CONFIG_PACKAGE_luci-app-msd_lite=y" >> .config
# 常用
#echo "CONFIG_PACKAGE_luci-app-adguardhome=y" >> .config
#echo "CONFIG_PACKAGE_luci-app-alist=y" >> .config
#echo "CONFIG_PACKAGE_luci-app-openclash=y" >> .config
#echo "CONFIG_PACKAGE_luci-app-mosdns=y" >> .config
#echo "CONFIG_PACKAGE_luci-app-lucky=y" >> .config
#echo "CONFIG_PACKAGE_luci-app-airconnect=y" >> .config
#echo "CONFIG_PACKAGE_luci-app-tailscale=y" >> .config
