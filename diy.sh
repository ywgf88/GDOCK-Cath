echo '修改机器名称'
sed -i 's/OpenWrt/G-DOCK/g' package/base-files/files/bin/config_generate

echo '修改网关地址'
sed -i 's/192.168.1.1/10.10.10.8/g' package/base-files/files/bin/config_generate

echo '修改时区'
sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

echo '修改默认主题'
sed -i 's/config internal themes/config internal themes\n    option Argon  \"\/luci-static\/argon\"/g' feeds/luci/modules/luci-base/root/etc/config/luci

echo '去除默认bootstrap主题'
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

#echo '删除旧版argon,链接新版'
rm -rf ./package/lean/luci-theme-argon
#ln -s ../../../luci-theme-argon ./package/lean/

echo '修改wifi名称'
sed -i 's/OpenWrt/G-DOCK/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

echo '修改banner'
rm -rf package/base-files/files/etc/banner
cp -f ../banner package/base-files/files/etc/

echo '下载ServerChan'
git clone https://github.com/tty228/luci-app-serverchan ../diy/luci-app-serverchan

echo '下载新的主题lignt and night'
git clone https://github.com/Aslin-Ameng/luci-theme-Light.git ../diy/luci-theme-Light
git clone https://github.com/Aslin-Ameng/luci-theme-Night.git ../diy/luci-theme-Night
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git ../diy/luci-theme-opentomcat
git clone https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon -b 18.06 ../diy/luci-theme-argon

# 添加第三方软件包
git clone https://github.com/kenzok8/openwrt-packages ../diy/openwrt-packages
git clone https://github.com/destan19/OpenAppFilter ../diy/OpenAppFilter


echo '集成diy目录'
ln -s ../../diy ./package/openwrt-packages

echo '首页增加CPU频率动态显示'
cp -f ../diy/mod-index.htm ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm

