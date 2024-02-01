# Palworld Server Monitor

This Ruby script is specifically crafted to address memory shortages frequently encountered in Palworld dedicated servers. As the Palworld server environment often faces memory constraints, this script is engineered to monitor memory usage diligently. When the memory usage surpasses the designated threshold, the script initiates an automatic cleanup of Linux memory. However, if memory usage persists above the threshold even after executing the cache cleaning script, this script will restart the Palworld server service.

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
# run the memory monitor script every 5 minutes and record all the logs in monitor_memory.log
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
