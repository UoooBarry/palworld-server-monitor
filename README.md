# Palworld Server Monitor

This ruby script is designed to monitor dedicated server memory usage. When memory usage exceeds the threshold, the script automatically cleans up Linux memory. If memory usage is still above the threshold after running the clean caches script, the Palworld server service will be restarted.

## Configuration

Copy the example configuration file

    $ cp ./configs/settings.example.yml settings.yml

```yml
# configs/settings.yml

services:
  palworld_service: "pal_server" # systemctl service name
rcon_connection: # modify Pal/Saved/Config/LinuxServer/PalWorldSettings.ini to enable rcon
  enable: false # when this option is enabled, palworld server will broadcast a message before the server be restarted.
  host: localhost
  port: 25575 # RCONPort in PalWorldSettings.ini
  password: # AdminPassword in PalWorldSettings.ini
```

## Usage

Install dependencies
```bash
bundle install
```

After configured, you could add this script to crontab: `crontab -e`.

```crontab
*/5 * * * * bundle exec ruby /palworld-server-monitor/main.rb >> /home/ubuntu/monitor_memory.log 2>&1
```
