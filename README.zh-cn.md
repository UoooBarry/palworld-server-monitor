# Palworld 服务器监控

这个 Ruby 脚本专门针对 Palworld 专用服务器经常遇到的内存不足问题进行了优化设计。由于 Palworld 服务器环境经常面临内存限制，该脚本旨在自动监视内存使用情况。当内存使用量超过指定阈值时，脚本会自动清理 Linux 内存。在执行缓存清理脚本后，如果内存使用量仍然超过在阈值，脚本将重新启动 Palworld 服务器服务。

## 配置

复制示例配置文件

    $ cp ./configs/settings.example.yml ./configs/settings.yml

```yaml
# configs/settings.yml

services:
  palworld_service: "pal_server" # systemctl service name_relative
  restart_threshold: 95 # 一旦超过此阈值，palworld_service 将清理缓存并重新启动
rcon_connection: # 修改 Pal/Saved/Config/LinuxServer/PalWorldSettings.ini 以启用 rcon
  enable: false # 启用此选项时，Palworld 服务器将在重新启动之前广播一条消息。
  host: localhost
  port: 25575 # PalWorldSettings.ini 中的 RCONPort
  password: # PalWorldSettings.ini 中的 AdminPassword
```

## 用法

### 监视 RAM 使用情况

安装依赖项
```bash
bundle install
```

配置完成后，您可以将此脚本添加到 crontab：sudo crontab -e。

```bash
# 每 5 分钟运行一次内存监控脚本，并将所有日志记录在 monitor_memory.log 中
*/5 * * * * cd /palworld-server-monitor && bundle exec main.rb >> /palworld-server-monitor/logs/monitor_memory.log 2>&1
```

### 定期重启

```bash
# 每 6 小时重启一次服务，并将所有日志记录在 monitor_memory.log 中
0 */6 * * * /palworld-server-monitor && bundle exec reboot.rb >> /palworld-server-monitor/logs/monitor_memory.log 2>&1
```

### 定期清理缓存

```bash
# 每 10 分钟运行 clean_caches 脚本
*/10 * * * * /palworld-server-monitor/cmd/clean_caches.sh
```