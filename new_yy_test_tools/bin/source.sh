#!/bin/bash

ubuntu_src_update() {
FILE=/etc/apt/sources.list
SRC="$1"
if [ "$SRC" == "" ];then
	SRC=duowan
fi
cat /etc/issue|grep "Ubuntu"
if [ "$?" -ne 0 ];then
	echo "System is $(cat /etc/issue)"
	echo "update ubuntu-$CODENAME fail!!!!!"
	exit 1
fi

CODENAME=`/usr/bin/lsb_release -a 2>/dev/null|grep Codename|awk -F ":" '{print $2}'`
duowan_ubuntu_src()
{
(
cat << eof
deb http://mirror.yy.duowan.com:63782/ubuntu/ $CODENAME main restricted universe multiverse
deb http://mirror.yy.duowan.com:63782/ubuntu/ $CODENAME-security main restricted universe multiverse
deb http://mirror.yy.duowan.com:63782/ubuntu/ $CODENAME-updates main restricted universe multiverse
deb http://mirror.yy.duowan.com:63782/ubuntu/ $CODENAME-proposed main restricted universe multiverse
deb http://mirror.yy.duowan.com:63782/ubuntu/ $CODENAME-backports main restricted universe multiverse
deb-src http://mirror.yy.duowan.com:63782/ubuntu/ $CODENAME main restricted universe multiverse
deb-src http://mirror.yy.duowan.com:63782/ubuntu/ $CODENAME-security main restricted universe multiverse
deb-src http://mirror.yy.duowan.com:63782/ubuntu/ $CODENAME-updates main restricted universe multiverse
deb-src http://mirror.yy.duowan.com:63782/ubuntu/ $CODENAME-proposed main restricted universe multiverse
deb-src http://mirror.yy.duowan.com:63782/ubuntu/ $CODENAME-backports main restricted universe multiverse
eof
)
}

wangyi_ubuntu_src ()
{
(
cat << eof
deb http://mirrors.163.com/ubuntu/ $CODENAME main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ $CODENAME-security main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ $CODENAME-updates main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ $CODENAME-proposed main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ $CODENAME-backports main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ $CODENAME main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ $CODENAME-security main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ $CODENAME-updates main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ $CODENAME-proposed main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ $CODENAME-backports main restricted universe multiverse
eof
)
}

cn99_ubuntu_src ()
{
(
cat << eof
deb http://ubuntu.cn99.com/ubuntu/ $CODENAME main restricted universe multiverse
deb http://ubuntu.cn99.com/ubuntu/ $CODENAME-security main restricted universe multiverse
deb http://ubuntu.cn99.com/ubuntu/ $CODENAME-updates main restricted universe multiverse
deb http://ubuntu.cn99.com/ubuntu/ $CODENAME-proposed main restricted universe multiverse
deb http://ubuntu.cn99.com/ubuntu/ $CODENAME-backports main restricted universe multiverse
deb-src http://ubuntu.cn99.com/ubuntu/ $CODENAME main restricted universe multiverse
deb-src http://ubuntu.cn99.com/ubuntu/ $CODENAME-security main restricted universe multiverse
deb-src http://ubuntu.cn99.com/ubuntu/ $CODENAME-updates main restricted universe multiverse
deb-src http://ubuntu.cn99.com/ubuntu/ $CODENAME-proposed main restricted universe multiverse
deb-src http://ubuntu.cn99.com/ubuntu/ $CODENAME-backports main restricted universe multiverse
deb http://ubuntu.cn99.com/ubuntu-cn/ $CODENAME main restricted universe multiverse
eof
)
}

offical_ubuntu_src ()
{
(
cat << eof
deb http://ubuntu.srt.cn/ubuntu/ $CODENAME main restricted universe multiverse
deb http://ubuntu.srt.cn/ubuntu/ $CODENAME-security main restricted universe multiverse
deb http://ubuntu.srt.cn/ubuntu/ $CODENAME-updates main restricted universe multiverse
deb http://ubuntu.srt.cn/ubuntu/ $CODENAME-proposed main restricted universe multiverse
deb http://ubuntu.srt.cn/ubuntu/ $CODENAME-backports main restricted universe multiverse
deb-src http://ubuntu.srt.cn/ubuntu/ $CODENAME main restricted universe multiverse
deb-src http://ubuntu.srt.cn/ubuntu/ $CODENAME-security main restricted universe multiverse
deb-src http://ubuntu.srt.cn/ubuntu/ $CODENAME-updates main restricted universe multiverse
deb-src http://ubuntu.srt.cn/ubuntu/ $CODENAME-proposed main restricted universe multiverse
deb-src http://ubuntu.srt.cn/ubuntu/ $CODENAME-backports main restricted universe multiverse
eof
)
}

if [ -f /etc/apt/sources.list ];then
	mv /etc/apt/sources.list /etc/apt/sources.list.bak
fi

[ "$SRC" == "duowan" ] && $(duowan_ubuntu_src > $FILE)
[ "$SRC" == "offical" ] && $(offical_ubuntu_src > $FILE)
[ "$SRC" == "cn99" ] && $(cn99_ubuntu_src > $FILE)
[ "$SRC" == "wangyi" ] && $(wangyi_ubuntu_src > $FILE)

echo "update ubuntu-$CODENAME source successful"
}

centos_src_update() {

# 配置yum源
cd /etc/yum.repos.d && rm -rf bak/ > /dev/null 2>&1 && mkdir bak
for a in `ls -l|awk '{print $NF}'|grep -v "bak"`;do
	mv $a bak/.
done

SERVER_ARCH=`/usr/bin/getconf LONG_BIT`
# redhat6源配置
cat /etc/issue|grep " 6\."
if [ "$?" -eq 0 ];then
(
cat <<'EOF'
[base]
name=CentOS-6 - Base
baseurl=http://mirror.yy.duowan.com:63782/centos/centos6-$basearch/RPMS.os
gpgcheck=1
gpgkey=http://mirror.yy.duowan.com:63782/centos/RPM-GPG-KEY-CentOS-6
[updates]
name=CentOS-6 - Updates
baseurl=http://mirror.yy.duowan.com:63782/centos/centos6-$basearch/RPMS.updates
gpgcheck=1
gpgkey=http://mirror.yy.duowan.com:63782/centos/RPM-GPG-KEY-CentOS-6
[fasttrack]
name=CentOS-6 - fasttrack
baseurl=http://mirror.yy.duowan.com:63782/centos/centos6-$basearch/RPMS.fasttrack
gpgcheck=1
gpgkey=http://mirror.yy.duowan.com:63782/centos/RPM-GPG-KEY-CentOS-6
[centosplus]
name=CentOS-6 - Plus
baseurl=http://mirror.yy.duowan.com:63782/centos/centos6-$basearch/RPMS.centosplus
gpgcheck=1
gpgkey=http://mirror.yy.duowan.com:63782/centos/RPM-GPG-KEY-CentOS-6
[extras]
name=CentOS-6 - extras
baseurl=http://mirror.yy.duowan.com:63782/centos/centos6-$basearch/RPMS.extras
gpgcheck=1
gpgkey=http://mirror.yy.duowan.com:63782/centos/RPM-GPG-KEY-CentOS-6
[addons]
name=CentOS-6 - addons
baseurl=http://mirror.yy.duowan.com:63782/centos/centos6-$basearch/RPMS.addons
gpgcheck=1
gpgkey=http://mirror.yy.duowan.com:63782/centos/RPM-GPG-KEY-CentOS-6

[buildtools]
name=CentOS-6 - buildtools
baseurl=http://mirror.yy.duowan.com:63782/centos/centos6-$basearch/RPMS.buildtools
[dag]
name=CentOS-6 - dag
baseurl=http://mirror.yy.duowan.com:63782/centos/centos6-$basearch/RPMS.dag
[rpmforge]
name=CentOS-6 - rpmforge
baseurl=http://mirror.yy.duowan.com:63782/centos/centos6-$basearch/RPMS.rpmforge
[testing]
name=CentOS-6 - testing
baseurl=http://mirror.yy.duowan.com:63782/centos/centos6-$basearch/RPMS.testing

[epel]
name=CentOS-6 - epel
baseurl=http://mirror.yy.duowan.com:63782/centos/centos6-$basearch/RPMS.epel
gpgcheck=1
gpgkey=http://mirror.yy.duowan.com:63782/centos/RPM-GPG-KEY-EPEL-6
[epel-debuginfo]
name=CentOS-6 - epel-debuginfo
baseurl=http://mirror.yy.duowan.com:63782/centos/centos6-$basearch/RPMS.epel-debuginfo
gpgcheck=1
gpgkey=http://mirror.yy.duowan.com:63782/centos/RPM-GPG-KEY-EPEL-6
[epel-source]
name=CentOS-6 - epel-source
baseurl=http://mirror.yy.duowan.com:63782/centos/centos6-$basearch/RPMS.epel-source
gpgcheck=1
gpgkey=http://mirror.yy.duowan.com:63782/centos/RPM-GPG-KEY-EPEL-6
[epel-testing]
name=CentOS-6 - epel-testing
baseurl=http://mirror.yy.duowan.com:63782/centos/centos6-$basearch/RPMS.epel-testing
gpgcheck=1
gpgkey=http://mirror.yy.duowan.com:63782/centos/RPM-GPG-KEY-EPEL-6
[epel-testing-debuginfo]
name=CentOS-6 - epel-testing-debuginfo
baseurl=http://mirror.yy.duowan.com:63782/centos/centos6-$basearch/RPMS.epel-testing-debuginfo
gpgcheck=1
gpgkey=http://mirror.yy.duowan.com:63782/centos/RPM-GPG-KEY-EPEL-6
[epel-testing-source]
name=CentOS-6 - epel-testing-source
baseurl=http://mirror.yy.duowan.com:63782/centos/centos6-$basearch/RPMS.epel-testing-source
gpgcheck=1
gpgkey=http://mirror.yy.duowan.com:63782/centos/RPM-GPG-KEY-EPEL-6
EOF
) > /etc/yum.repos.d/mirror.yy.duowan.com.repo 

	# gpg key导入
	if [ "$SERVER_ARCH" = "32" ];then
		wget http://mirror.yy.duowan.com:63782/centos/rpmforge-release-0.5.2-2.el6.rf.i686.rpm
	else
		wget http://mirror.yy.duowan.com:63782/centos/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm
	fi
	rpm -ivh rpmforge-release*.rpm

# redhat5源配置
else
(
cat <<'EOF'
[base]
name=CentOS-5 - Base - 163.com
mirrorlist=http://mirrorlist.centos.org/?release=5&arch=$basearch&repo=os
baseurl=http://mirrors.163.com/centos/5/os/$basearch/
gpgcheck=1
gpgkey=http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-5
[updates]
name=CentOS-5 - Updates - 163.com
mirrorlist=http://mirrorlist.centos.org/?release=5&arch=$basearch&repo=updates
baseurl=http://mirrors.163.com/centos/5/updates/$basearch/
gpgcheck=1
gpgkey=http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-5
[addons]
name=CentOS-5 - Addons - 163.com
mirrorlist=http://mirrorlist.centos.org/?release=5&arch=$basearch&repo=addons
baseurl=http://mirrors.163.com/centos/5/addons/$basearch/
gpgcheck=1
gpgkey=http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-5
[extras]
name=CentOS-5 - Extras - 163.com
mirrorlist=http://mirrorlist.centos.org/?release=5&arch=$basearch&repo=extras
baseurl=http://mirrors.163.com/centos/5/extras/$basearch/
gpgcheck=1
gpgkey=http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-5
[centosplus]
name=CentOS-5 - Plus - 163.com
mirrorlist=http://mirrorlist.centos.org/?release=5&arch=$basearch&repo=centosplus
baseurl=http://mirrors.163.com/centos/5/centosplus/$basearch/
gpgcheck=1
enabled=0
gpgkey=http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-5
[contrib]
name=CentOS-5 - Contrib - 163.com
mirrorlist=http://mirrorlist.centos.org/?release=5&arch=$basearch&repo=contrib
baseurl=http://mirrors.163.com/centos/5/contrib/$basearch/
gpgcheck=1
enabled=0
gpgkey=http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-5
EOF
) > /etc/yum.repos.d/mirror.yy.duowan.com.repo 

	if [[ "$SERVER_ARCH" = "32" ]] && [[ "$SERVER_ARCH" = "32" ]];then
		wget http://mirror.yy.duowan.com:63782/centos/rpmforge-release-0.5.2-2.el5.rf.i386.rpm
		rpm -ivh rpmforge-release*.rpm
	else
		wget http://mirror.yy.duowan.com:63782/centos/rpmforge-release-0.5.2-2.el5.rf.x86_64.rpm
		rpm -ivh rpmforge-release*.rpm
	fi
	
	yum clean metadata
	yum makecache
fi
}

cat /etc/hosts | grep "mirror.yy.duowan.com"
[ "$?" -ne 0 ] && $(echo "58.215.46.21	mirror.yy.duowan.com" >> /etc/hosts)

cat /etc/issue|grep -E "CentOS|Red"
if [ "$?" -ne 0 ];then
	ubuntu_src_update
else
	centos_src_update
fi

exit 0
