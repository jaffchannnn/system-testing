#!/bin/sh
INSTALLER_VERSION="1.3.0"

##Region
INTERNET_POSTFIX="_internet"
VPC_POSTFIX="_vpc"
INNER_POSTFIX="_inner"
FINANCE_POSTFIX="-finance"
OLD_FINANCE_POSTFIX="_finance"

CN_BEIJING="cn-beijing"
CN_BEIJING_INTERNET=$CN_BEIJING$INTERNET_POSTFIX
CN_BEIJING_VPC=$CN_BEIJING$VPC_POSTFIX
CN_BEIJING_INNER=$CN_BEIJING$INNER_POSTFIX

CN_BEIJING_OLD="cn_beijing"
CN_BEIJING_OLD_INTERNET=$CN_BEIJING_OLD$INTERNET_POSTFIX
CN_BEIJING_OLD_VPC=$CN_BEIJING_OLD$VPC_POSTFIX
CN_BEIJING_OLD_INNER=$CN_BEIJING_OLD$INNER_POSTFIX

CN_QINGDAO="cn-qingdao"
CN_QINGDAO_INTERNET=$CN_QINGDAO$INTERNET_POSTFIX
CN_QINGDAO_INNER=$CN_QINGDAO$INNER_POSTFIX
CN_QINGDAO_VPC=$CN_QINGDAO$VPC_POSTFIX

CN_QINGDAO_OLD="cn_qingdao"
CN_QINGDAO_OLD_INTERNET=$CN_QINGDAO_OLD$INTERNET_POSTFIX
CN_QINGDAO_OLD_INNER=$CN_QINGDAO_OLD$INNER_POSTFIX
CN_QINGDAO_OLD_VPC=$CN_QINGDAO_OLD$VPC_POSTFIX

CN_SHANGHAI="cn-shanghai"
CN_SHANGHAI_INTERNET=$CN_SHANGHAI$INTERNET_POSTFIX
CN_SHANGHAI_VPC=$CN_SHANGHAI$VPC_POSTFIX
CN_SHANGHAI_INNER=$CN_SHANGHAI$INNER_POSTFIX
CN_SHANGHAI_FINANCE=$CN_SHANGHAI$FINANCE_POSTFIX

CN_SHANGHAI_OLD="cn_shanghai"
CN_SHANGHAI_OLD_INTERNET=$CN_SHANGHAI_OLD$INTERNET_POSTFIX
CN_SHANGHAI_OLD_VPC=$CN_SHANGHAI_OLD$VPC_POSTFIX
CN_SHANGHAI_OLD_INNER=$CN_SHANGHAI_OLD$INNER_POSTFIX
CN_SHANGHAI_OLD_FINANCE=$CN_SHANGHAI_OLD$OLD_FINANCE_POSTFIX

CN_HANGZHOU="cn-hangzhou"
CN_HANGZHOU_INTERNET=$CN_HANGZHOU$INTERNET_POSTFIX
CN_HANGZHOU_VPC=$CN_HANGZHOU$VPC_POSTFIX
CN_HANGZHOU_FINANCE=$CN_HANGZHOU$FINANCE_POSTFIX
CN_HANGZHOU_INNER=$CN_HANGZHOU$INNER_POSTFIX

CN_HANGZHOU_OLD="cn_hangzhou"
CN_HANGZHOU_OLD_INTERNET=$CN_HANGZHOU_OLD$INTERNET_POSTFIX
CN_HANGZHOU_OLD_VPC=$CN_HANGZHOU_OLD$VPC_POSTFIX
CN_HANGZHOU_OLD_FINANCE=$CN_HANGZHOU_OLD$OLD_FINANCE_POSTFIX
CN_HANGZHOU_OLD_INNER=$CN_HANGZHOU_OLD$INNER_POSTFIX

CN_SHENZHEN="cn-shenzhen"
CN_SHENZHEN_INTERNET=$CN_SHENZHEN$INTERNET_POSTFIX
CN_SHENZHEN_VPC=$CN_SHENZHEN$VPC_POSTFIX
CN_SHENZHEN_FINANCE=$CN_SHENZHEN$FINANCE_POSTFIX
CN_SHENZHEN_INNER=$CN_SHENZHEN$INNER_POSTFIX

CN_SHENZHEN_OLD="cn_shenzhen"
CN_SHENZHEN_OLD_INTERNET=$CN_SHENZHEN_OLD$INTERNET_POSTFIX
CN_SHENZHEN_OLD_VPC=$CN_SHENZHEN_OLD$VPC_POSTFIX
CN_SHENZHEN_OLD_FINANCE=$CN_SHENZHEN_OLD$OLD_FINANCE_POSTFIX
CN_SHENZHEN_OLD_INNER=$CN_SHENZHEN_OLD$INNER_POSTFIX

CN_ZHANGJIAKOU="cn-zhangjiakou"
CN_ZHANGJIAKOU_INTERNET=$CN_ZHANGJIAKOU$INTERNET_POSTFIX
CN_ZHANGJIAKOU_VPC=$CN_ZHANGJIAKOU$VPC_POSTFIX
CN_ZHANGJIAKOU_INNER=$CN_ZHANGJIAKOU$INNER_POSTFIX

CN_HUHEHAOTE="cn-huhehaote"
CN_HUHEHAOTE_INTERNET=$CN_HUHEHAOTE$INTERNET_POSTFIX
CN_HUHEHAOTE_INNER=$CN_HUHEHAOTE$INNER_POSTFIX

CN_CHENGDU="cn-chengdu"
CN_CHENGDU_INTERNET=$CN_CHENGDU$INTERNET_POSTFIX
CN_CHENGDU_INNER=$CN_CHENGDU$INNER_POSTFIX

CN_HONGKONG="cn-hongkong"
CN_HONGKONG_INTERNET=$CN_HONGKONG$INTERNET_POSTFIX
CN_HONGKONG_VPC=$CN_HONGKONG$VPC_POSTFIX
CN_HONGKONG_INNER=$CN_HONGKONG$INNER_POSTFIX

AP_NORTHEAST_1="ap-northeast-1"
AP_NORTHEAST_1_INTERNET=$AP_NORTHEAST_1$INTERNET_POSTFIX
AP_NORTHEAST_1_VPC=$AP_NORTHEAST_1$VPC_POSTFIX
AP_NORTHEAST_1_INNER=$AP_NORTHEAST_1$INNER_POSTFIX

AP_SOUTHEAST_1="ap-southeast-1"
AP_SOUTHEAST_1_INTERNET=$AP_SOUTHEAST_1$INTERNET_POSTFIX
AP_SOUTHEAST_1_VPC=$AP_SOUTHEAST_1$VPC_POSTFIX
AP_SOUTHEAST_1_INNER=$AP_SOUTHEAST_1$INNER_POSTFIX

AP_SOUTHEAST_2="ap-southeast-2"
AP_SOUTHEAST_2_INTERNET=$AP_SOUTHEAST_2$INTERNET_POSTFIX
AP_SOUTHEAST_2_VPC=$AP_SOUTHEAST_2$VPC_POSTFIX
AP_SOUTHEAST_2_INNER=$AP_SOUTHEAST_2$INNER_POSTFIX

AP_SOUTHEAST_3="ap-southeast-3"
AP_SOUTHEAST_3_INTERNET=$AP_SOUTHEAST_3$INTERNET_POSTFIX
AP_SOUTHEAST_3_INNER=$AP_SOUTHEAST_3$INNER_POSTFIX

AP_SOUTHEAST_5="ap-southeast-5"
AP_SOUTHEAST_5_INTERNET=$AP_SOUTHEAST_5$INTERNET_POSTFIX
AP_SOUTHEAST_5_INNER=$AP_SOUTHEAST_5$INNER_POSTFIX

EU_CENTRAL_1="eu-central-1"
EU_CENTRAL_1_INTERNET=$EU_CENTRAL_1$INTERNET_POSTFIX
EU_CENTRAL_1_VPC=$EU_CENTRAL_1$VPC_POSTFIX
EU_CENTRAL_1_INNER=$EU_CENTRAL_1$INNER_POSTFIX

ME_EAST_1="me-east-1"
ME_EAST_1_INTERNET=$ME_EAST_1$INTERNET_POSTFIX
ME_EAST_1_VPC=$ME_EAST_1$VPC_POSTFIX
ME_EAST_1_INNER=$ME_EAST_1$INNER_POSTFIX

US_WEST_1="us-west-1"
US_WEST_1_INTERNET=$US_WEST_1$INTERNET_POSTFIX
US_WEST_1_VPC=$US_WEST_1$VPC_POSTFIX
US_WEST_1_INNER=$US_WEST_1$INNER_POSTFIX

US_EAST_1="us-east-1"
US_EAST_1_INTERNET=$US_EAST_1$INTERNET_POSTFIX
US_EAST_1_INNER=$US_EAST_1$INNER_POSTFIX

AP_SOUTH_1="ap-south-1"
AP_SOUTH_1_INTERNET=$AP_SOUTH_1$INTERNET_POSTFIX
AP_SOUTH_1_INNER=$AP_SOUTH_1$INNER_POSTFIX

##logtail package
PACKAGE_NAME="logtail-linux64.tar.gz"

##ilogtaild script
CONTROLLER_DIR="/etc/init.d"
CONTROLLER_FILE="ilogtaild"

##ilogtail binary
BIN_DIR="/usr/local/ilogtail"
BIN_FILE="ilogtail"

##config file
README_FILE="README"
CA_CERT_FILE="ca-bundle.crt"
CONFIG_FILE="ilogtail_config.json"

##arch
X64="x86_64"
X32="i386"

##os version
CENTOS_OS="CentOS"
UBUNTU_OS="Ubuntu"
DEBIAN_OS="Debian"
ALIYUN_OS="Aliyun"
OPENSUSE_OS="openSUSE"
OTHER_OS="other"

CURRENT_DIR=`dirname "$0"`

logError()
{
    echo -n '[Error]:   '  $*
    echo -en '\033[120G \033[31m' && echo [ Error ]
    echo -en '\033[0m'
}

download_file()
{
    package_address=""
    if [ `echo $1 | grep $INTERNET_POSTFIX | wc -l` -ge 1 ]; then
        package_address="http://logtail-release.oss-cn-hangzhou.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ `echo $1 | grep $INNER_POSTFIX | wc -l` -ge 1 ]; then
        package_address="http://logtail-release.oss-cn-hangzhou.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $CN_BEIJING ] || [ $1 = $CN_BEIJING_OLD ]; then
        package_address="http://logtail-release-bj.oss-cn-beijing-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $CN_QINGDAO ] || [ $1 = $CN_QINGDAO_OLD ]; then
        package_address="http://logtail-release-qd.oss-cn-qingdao-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $CN_SHANGHAI ] || [ $1 = $CN_SHANGHAI_OLD ]; then
        package_address="http://logtail-release-sh.oss-cn-shanghai-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $CN_HANGZHOU ] || [ $1 = $CN_HANGZHOU_OLD ]; then
        package_address="http://logtail-release.oss-cn-hangzhou-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $CN_SHENZHEN ] || [ $1 = $CN_SHENZHEN_OLD ]; then
        package_address="http://logtail-release-sz.oss-cn-shenzhen-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $CN_BEIJING_VPC ] || [ $1 = $CN_BEIJING_OLD_VPC ]; then
        package_address="http://logtail-release-bj.vpc100-oss-cn-beijing.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $CN_QINGDAO_VPC ] || [ $1 = $CN_QINGDAO_OLD_VPC ]; then
        package_address="http://logtail-release-qd.vpc100-oss-cn-qingdao.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $CN_SHANGHAI_VPC ] || [ $1 = $CN_SHANGHAI_OLD_VPC ]; then
        package_address="http://logtail-release-sh.vpc100-oss-cn-shanghai.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $CN_HANGZHOU_VPC ] || [ $1 = $CN_HANGZHOU_OLD_VPC ]; then
        package_address="http://logtail-release.vpc100-oss-cn-hangzhou.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $CN_SHENZHEN_VPC ] || [ $1 = $CN_SHENZHEN_OLD_VPC ]; then
        package_address="http://logtail-release-sz.vpc100-oss-cn-shenzhen.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $CN_HANGZHOU_FINANCE ] || [ $1 = $CN_HANGZHOU_OLD_FINANCE ]; then
        package_address="http://logtail-release-hz-finance.oss-cn-hzjbp-a-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $CN_SHENZHEN_FINANCE ] || [ $1 = $CN_SHENZHEN_OLD_FINANCE ]; then
        package_address="http://logtail-release-sz-finance.oss-cn-shenzhen-finance-1-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $CN_SHANGHAI_FINANCE ] || [ $1 = $CN_SHANGHAI_OLD_FINANCE ]; then
        package_address="http://logtail-release-sh-finance.oss-cn-shanghai-finance-1-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $CN_ZHANGJIAKOU ] || [ $1 = $CN_ZHANGJIAKOU_VPC ]; then
        package_address="http://logtail-release-zjk.oss-cn-zhangjiakou-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $CN_HUHEHAOTE ]; then
        package_address="http://logtail-release-huhehaote.oss-cn-huhehaote-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $CN_CHENGDU ]; then
        package_address="http://logtail-release-cn-chengdu.oss-cn-chengdu-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $AP_NORTHEAST_1 ] || [ $1 = $AP_NORTHEAST_1_VPC ]; then
        package_address="http://logtail-release-ap-northeast-1.oss-ap-northeast-1-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $AP_SOUTHEAST_1 ]; then
        package_address="http://logtail-release-ap-southeast-1.oss-ap-southeast-1-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $AP_SOUTHEAST_1_VPC ]; then
        package_address="http://logtail-release-ap-southeast-1.vpc100-oss-ap-southeast-1.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $AP_SOUTHEAST_2 ] || [ $1 = $AP_SOUTHEAST_2_VPC ]; then
        package_address="http://logtail-release-ap-southeast-2.oss-ap-southeast-2-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $AP_SOUTHEAST_3 ]; then
        package_address="http://logtail-release-ap-southeast-3.oss-ap-southeast-3-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $AP_SOUTHEAST_5 ]; then
        package_address="http://logtail-release-ap-southeast-5.oss-ap-southeast-5-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $EU_CENTRAL_1 ] || [ $1 = $EU_CENTRAL_1_VPC ]; then
        package_address="http://logtail-release-eu-central-1.oss-eu-central-1-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $ME_EAST_1 ] || [ $1 = $ME_EAST_1_VPC ]; then
        package_address="http://logtail-release-me-east-1.oss-me-east-1-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $US_WEST_1 ]; then
        package_address="http://logtail-release-us-west-1.oss-us-west-1-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $US_EAST_1 ]; then
        package_address="http://logtail-release-us-east-1.oss-us-east-1-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $AP_SOUTH_1 ]; then
        package_address="http://logtail-release-ap-south-1.oss-ap-south-1-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $US_WEST_1_VPC ]; then
        package_address="http://logtail-release-us-west-1.vpc100-oss-us-west-1.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $CN_HONGKONG ]; then
        package_address="http://logtail-release-hk.oss-cn-hongkong-internal.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    elif [ $1 = $CN_HONGKONG_VPC ]; then
        package_address="http://logtail-release-hk.vpc100-oss-cn-hongkong.aliyuncs.com/linux64/logtail-linux64.tar.gz"
    else
        logError "invalid install parameters"
        exit 1
    fi
    wget $package_address -O $PACKAGE_NAME -t 1
    if [ $? != 0 ]; then
        logError "Download logtail install file failed."
        rm -f $PACKAGE_NAME
        exit 1
    fi
}

do_install()
{
    if [ $3 = "install" ]; then
        rm -f $PACKAGE_NAME
        download_file $2
    fi
    if [ -f $PACKAGE_NAME ]; then
        echo $PACKAGE_NAME" download success"
    else
        logError $PACKAGE_NAME" download fail, exit"
        exit 1
    fi
    tar -zxf $PACKAGE_NAME
    binary_version=`ls $CURRENT_DIR/logtail-linux64/bin/ilogtail_* | awk -F"_" '{print $2}'`
    if [ ! -f $CURRENT_DIR/logtail-linux64/conf/$2"/"$CONFIG_FILE ]; then
        logError "Can not find specific config file " $CURRENT_DIR/logtail-linux64/conf/$2"/"$CONFIG_FILE
        rm -rf logtail-linux64
        rm -f $PACKAGE_NAME
        exit 1
    fi
    mkdir -p $BIN_DIR
    mkdir -p $CONTROLLER_DIR
    cp $CURRENT_DIR/logtail-linux64/bin/$BIN_FILE"_"$binary_version $BIN_DIR/
    cp $CURRENT_DIR/logtail-linux64/bin/LogtailInsight $BIN_DIR/
    cp $CURRENT_DIR/logtail-linux64/bin/libPluginAdapter.so $BIN_DIR/
    cp $CURRENT_DIR/logtail-linux64/bin/libPluginBase.so $BIN_DIR/
    ln -s $BIN_DIR/$BIN_FILE"_"$binary_version $BIN_DIR/$BIN_FILE
    cp $CURRENT_DIR/logtail-linux64/$README_FILE $BIN_DIR
    cp $CURRENT_DIR/logtail-linux64/resources/$CA_CERT_FILE $BIN_DIR
    cp $CURRENT_DIR/logtail-linux64/conf/$2"/"$CONFIG_FILE $BIN_DIR/$CONFIG_FILE
    cp $CURRENT_DIR/logtail-linux64/bin/$CONTROLLER_FILE $CONTROLLER_DIR
    echo "install logtail files success"
    chmod 755 $BIN_DIR -R
    chown root $BIN_DIR -R
    chgrp root $BIN_DIR -R
    chmod 755 $CONTROLLER_DIR/$CONTROLLER_FILE
    chown root $CONTROLLER_DIR/$CONTROLLER_FILE
    chgrp root $CONTROLLER_DIR/$CONTROLLER_FILE

    if [ $1 = $ALIYUN_OS ] || [ $1 = $CENTOS_OS ] || [ $1 = $OPENSUSE_OS ]; then
        chkconfig --add $CONTROLLER_FILE
        chkconfig $CONTROLLER_FILE on
        echo "chkconfig add ilogtaild success"
    elif [ $1 = $DEBIAN_OS ] || [ $1 = $UBUNTU_OS ]; then
        update-rc.d $CONTROLLER_FILE start 55 2 3 4 5 . stop 45 0 1 6 .
        echo "update-rc.d add ilogtaild success"
    else
        ln -s $CONTROLLER_DIR/$CONTROLLER_FILE /etc/rc.d/rc0.d/K45$CONTROLLER_FILE
        ln -s $CONTROLLER_DIR/$CONTROLLER_FILE /etc/rc.d/rc1.d/K45$CONTROLLER_FILE
        ln -s $CONTROLLER_DIR/$CONTROLLER_FILE /etc/rc.d/rc2.d/S55$CONTROLLER_FILE
        ln -s $CONTROLLER_DIR/$CONTROLLER_FILE /etc/rc.d/rc3.d/S55$CONTROLLER_FILE
        ln -s $CONTROLLER_DIR/$CONTROLLER_FILE /etc/rc.d/rc4.d/S55$CONTROLLER_FILE
        ln -s $CONTROLLER_DIR/$CONTROLLER_FILE /etc/rc.d/rc5.d/S55$CONTROLLER_FILE
        ln -s $CONTROLLER_DIR/$CONTROLLER_FILE /etc/rc.d/rc6.d/K45$CONTROLLER_FILE
        echo "add ilogtail into /etc/rc.d/ success"
    fi
    echo "install logtail success"
    $CONTROLLER_DIR/$CONTROLLER_FILE start
    if [ $? -eq 0 ]; then
        echo "start logtail success"
    else
        logError "start logtail fail"
    fi
    sleep 0.5
    appinfo=$BIN_DIR"/app_info.json"
    if [ -f $appinfo ]; then
        cat $appinfo 
    fi
    rm -rf logtail-linux64
    rm -f $PACKAGE_NAME
}

do_uninstall()
{
    if [ -f $CONTROLLER_DIR/$CONTROLLER_FILE ]; then
        $CONTROLLER_DIR/$CONTROLLER_FILE stop
        if [ $? -eq 0 ]; then
            echo "stop logtail success"
        else
            logError "stop logtail fail"
        fi
    fi

    if [ $0 = $ALIYUN_OS ] || [ $1 = $CENTOS_OS ] || [ $1 = $OPENSUSE_OS ]; then
        chkconfig $CONTROLLER_FILE off
        chkconfig --del $CONTROLLER_FILE
        echo "chkconfig del ilogtaild success"
    elif [ $1 = $DEBIAN_OS ] || [ $1 = $UBUNTU_OS ]; then
        update-rc.d -f $CONTROLLER_FILE remove
        echo "update-rc.d del ilogtaild success"
    else
        if [ -f /etc/rc.d/rc0.d/K45$CONTROLLER_FILE ]; then
            unlink /etc/rc.d/rc0.d/K45$CONTROLLER_FILE
        fi
        if [ -f /etc/rc.d/rc1.d/K45$CONTROLLER_FILE ]; then
            unlink /etc/rc.d/rc1.d/K45$CONTROLLER_FILE
        fi
        if [ -f /etc/rc.d/rc2.d/S55$CONTROLLER_FILE ]; then
            unlink /etc/rc.d/rc2.d/S55$CONTROLLER_FILE
        fi
        if [ -f /etc/rc.d/rc3.d/S55$CONTROLLER_FILE ]; then
            unlink /etc/rc.d/rc3.d/S55$CONTROLLER_FILE
        fi
        if [ -f /etc/rc.d/rc4.d/S55$CONTROLLER_FILE ]; then
            unlink /etc/rc.d/rc4.d/S55$CONTROLLER_FILE
        fi
        if [ -f /etc/rc.d/rc5.d/S55$CONTROLLER_FILE ]; then
            unlink /etc/rc.d/rc5.d/S55$CONTROLLER_FILE
        fi
        if [ -f /etc/rc.d/rc6.d/K45$CONTROLLER_FILE ]; then
            unlink /etc/rc.d/rc6.d/K45$CONTROLLER_FILE
        fi
        echo "del ilogtaild from /etc/rc.d/ success"
    fi

    if [ -d $BIN_DIR ]; then
        rm -rf $BIN_DIR
    fi
    if [ -f $CONTROLLER_DIR/$CONTROLLER_FILE ]; then
        rm -f $CONTROLLER_DIR/$CONTROLLER_FILE
    fi
    echo "uninstall logtail success"
}

print_help()
{
    echo "Usage:"
    echo -e "\tlogtail.sh [install <REGION>] [uninstall] [install-local <REGION>]"
    echo "Parameter:"
    echo -e "\t<REGION>:"
    echo -e "\t(for ECS VM) $CN_BEIJING $CN_QINGDAO $CN_SHANGHAI $CN_HANGZHOU $CN_SHENZHEN $CN_ZHANGJIAKOU $AP_NORTHEAST_1 $AP_SOUTHEAST_1 $AP_SOUTHEAST_2 $EU_CENTRAL_1 $ME_EAST_1 $US_WEST_1 $CN_HONGKONG $CN_HUHEHAOTE $CN_CHENGDU $AP_SOUTHEAST_3 $AP_SOUTH_1 $US_EAST_1, etc."
    echo -e "\t(for Non-ECS VM or other IDC) $CN_BEIJING_INTERNET $CN_QINGDAO_INTERNET $CN_SHANGHAI_INTERNET $CN_HANGZHOU_INTERNET $CN_SHENZHEN_INTERNET $CN_ZHANGJIAKOU_INTERNET $AP_NORTHEAST_1_INTERNET $AP_SOUTHEAST_1_INTERNET $AP_SOUTHEAST_2_INTERNET $EU_CENTRAL_1_INTERNET $ME_EAST_1_INTERNET $US_WEST_1_INTERNET $CN_HONGKONG_INTERNET $CN_HUHEHAOTE_INTERNET $AP_SOUTHEAST_3_INTERNET $AP_SOUTH_1_INTERNET $US_EAST_1_INTERNET, etc."
    echo -e "\t(for ECS VM in Finance) $CN_HANGZHOU_FINANCE $CN_SHANGHAI_FINANCE $CN_SHENZHEN_FINANCE, etc."
    echo -e "\t(for Machine inner Alibaba Group) $CN_BEIJING_INNER $CN_QINGDAO_INNER $CN_SHANGHAI_INNER $CN_HANGZHOU_INNER $CN_SHENZHEN_INNER $CN_ZHANGJIAKOU_INNER $AP_NORTHEAST_1_INNER $AP_SOUTHEAST_1_INNER $AP_SOUTHEAST_2_INNER $EU_CENTRAL_1_INNER $ME_EAST_1_INNER $US_WEST_1_INNER $CN_HONGKONG_INNER $CN_HUHEHAOTE_INNER $AP_SOUTHEAST_3_INNER $AP_SOUTH_1_INNER $US_EAST_1_INNER, etc."
    echo "Commands:"
    echo -e "\tinstall $CN_BEIJING:\t (recommend) auto download package, install logtail to /usr/local/ilogtail, for $CN_BEIJING region"
    echo -e "\tuninstall:\t uninstall logtail from /usr/local/ilogtail"
}

echo "logtai.sh version: "$INSTALLER_VERSION
echo
ARCH=$X64
arch_issue=`uname -m | tr A-Z a-z`
if [ `uname -m | tr A-Z a-z` = "x86_64" ]; then
    ARCH=$X64
else
    ARCH=$X32
    echo "linux x86 not supported, exit"
    exit 1
fi

OS_VERSION=$OTHER_OS
os_issue=`cat /etc/issue | tr A-Z a-z`

get_os_version()
{
    if [ `echo $os_issue | grep debian | wc -l` -ge 1 ]; then
        OS_VERSION=$DEBIAN_OS
    elif [ `echo $os_issue | grep ubuntu | wc -l` -ge 1 ]; then
        OS_VERSION=$UBUNTU_OS
    elif [ `echo $os_issue | grep centos | wc -l` -ge 1 ]; then
        OS_VERSION=$CENTOS_OS
    elif [ `echo $os_issue | grep 'red hat' | wc -l` -ge 1 ]; then
        OS_VERSION=$CENTOS_OS
    elif [ `echo $os_issue | grep aliyun | wc -l` -ge 1 ]; then
        OS_VERSION=$ALIYUN_OS
    elif [ `echo $os_issue | grep opensuse | wc -l` -ge 1 ]; then
        OS_VERSION=$OPENSUSE_OS
    fi
}

get_os_version
if [ $OS_VERSION = $OTHER_OS ]; then
    echo -e "Can not get os version from /etc/issue, try lsb_release"
    os_issue=`lsb_release -a`
    get_os_version
fi

if [ $OS_VERSION = $OTHER_OS ]; then
    echo -e "Can not get os version from lsb_release, try check specific files"
    if [ -f "/etc/redhat-release" ]; then
        OS_VERSION=$CENTOS_OS
    elif [ -f "/etc/debian_version" ]; then
        OS_VERSION=$DEBIAN_OS
    else
        logError "Can not get os verison"
    fi
fi

echo -e "OS Arch:\t"$ARCH
echo -e "OS Distribution:\t"$OS_VERSION
case $# in
    0)
        print_help
        exit 1
        ;;
    1)
        case $1 in
            uninstall)
                do_uninstall $OS_VERSION
                ;;
            *)
                print_help
                exit 1
                ;;
        esac
        ;;
    2)
        if [ $1 = "install" ] || [ $1 = "install-local" ]; then
            do_uninstall $OS_VERSION
            do_install $OS_VERSION $2 $1
        else
            print_help
            exit 1
        fi
        ;;
    *)
        print_help
        exit 1
        ;;
esac

exit 0
