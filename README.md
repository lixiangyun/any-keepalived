### 获取镜像
```
$ docker pull registry.cn-hangzhou.aliyuncs.com/anoy/keepalived
```

### 快速启动
```
$ docker run \
  --cap-add=NET_ADMIN \
  --net=host \
  -d \
  --env KEEPALIVED_VIRTUAL_IPS="#PYTHON2BASH:['192.168.99.105', '192.168.99.106']" \
  --env KEEPALIVED_STATE="MASTER" \
  --detach \
  registry.cn-hangzhou.aliyuncs.com/anoyi/keepalived
```

参数说明：
- `KEEPALIVED_INTERFACE` 网络接口，默认 `eth0`
- `KEEPALIVED_PASSWORD` 密码，默认 `d0cker`
- `KEEPALIVED_PRIORITY` 节点优先级，默认 `150`
- `KEEPALIVED_VIRTUAL_IPS` 虚拟IP，可以指定多个，默认 `192.168.99.200`
- `KEEPALIVED_UNICAST_PEERS` ，默认 `192.168.1.10`
- `KEEPALIVED_STATE` 节点状态，MASTER 或 BACKUP，默认 `MASTER`
- `KEEPALIVED_NOTIFY` 节点状态变更时的执行脚本，默认`container/service/keepalived/assets/notify.sh`
- `KEEPALIVED_COMMAND_LINE_ARGUMENTS ` 命令行参数，默认`--log-detail --dump-conf`

### Debug
容器默认的日志级别是 `info`，可用类型有`none`, `error`, `warning`, `info`, `debug` 和 `trace`。
启动示例：
```
$ docker run \
  --cap-add=NET_ADMIN \
  --net=host \
  --detach \
  registry.cn-hangzhou.aliyuncs.com/anoyi/keepalived \
  --loglevel debug
```
