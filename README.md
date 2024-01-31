# Palworld Server Monitor

This ruby script is designed to monitor dedicated server memory usage. When memory usage exceeds the threshold, the script automatically cleans up Linux memory. If memory usage is still above the threshold after running the clean caches script, the Palworld server service will be rebooted.

## Configuration

Copy the example configuration file

    $ cp ./configs/settings.example.yml ./configs/settings.yml

```yml
# configs/settings.yml

services:
  palworld_service: "pal_server" # systemctl service name_relative
  restart_threshold: 95 # Once above this threshold, palworld_service will clean caches and restart
rcon_connection: # modify Pal/Saved/Config/LinuxServer/PalWorldSettings.ini to enable rcon
  enable: false # when this option is enabled, palworld server will broadcast a message before the server be restarted.
  host: localhost
  port: 25575 # RCONPort in PalWorldSettings.ini
  password: # AdminPassword in PalWorldSettings.ini
```

## Usage

### Monitor RAM usage

Install dependencies
```bash
bundle install
```

After configured, you could add this script to crontab: `sudo crontab -e`.

```bash
# run the script every 5 minutes and record all the logs in monitor_memory.log
*/5 * * * * cd /palworld-server-monitor && bundle exec main.rb >> /palworld-server-monitor/logs/monitor_memory.log 2>&1
```

### Schedule a regular reboot

```bash
# reboot the service 6 hours and record all the logs in monitor_memory.log
0 */6 * * * /palworld-server-monitor && bundle exec reboot.rb >> /palworld-server-monitor/logs/monitor_memory.log 2>&1
```

### Schedule a regular cache clean

```bash
# run clean_caches script every 10 minutes
*/10 * * * * /palworld-server-monitor/cmd/clean_caches.sh
```
