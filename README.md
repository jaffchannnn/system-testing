“#system-testing”
用于系统性能测试
测试项目与工具：

#cpu
工具：speccpu    #由于seccpu是企业付费软件，这里就没有po上来，自行网上寻找

#网卡
工具：netperf/iperf3
这里使用netperf和另一台机子进行配对测试。配置在run_test.sh中设置

#IO
工具：fio

#内存
工具：主要使用steam配合算法进行测试

#数据处理工具
IPupload.py 收割测试数据，并以get请求发送到远端nginx进行数据采集
