require 'yaml'
require 'palworld_rcon'
require 'time'
require_relative './configs/configuration'

class Hash
  def symbolize_keys
    transform_keys { |key| key.to_sym rescue key }
  end

  def except!(*keys)
    keys.each { |key| delete(key) }
    self
  end

  def except(*keys)
    dup.except!(*keys)
  end
end

config = configuration

# define timestamp
timestamp = Time.now.strftime("%Y-%m-%d %H:%M:%S")

# get current memory usage
def memory_usage
  memory_info = `free`
  memory_total = memory_info[/Mem:\s+(\d+)/, 1].to_f
  memory_used = memory_info[/Mem:\s+\d+\s+(\d+)/, 1].to_f
  (memory_used / memory_total) * 100
end

# set threshold
threshold = 90

if memory_usage > threshold
  # clean caches
  puts "[#{timestamp}] Memory usage is above #{threshold}%. Cleaning caches..."
  `./cmd/clean_caches.sh`
  sleep 10

  # check memory_usage after cleaning caches
  # restart pal_server if memory usage is till above threshold
  if memory_usage > threshold
    puts "[#{timestamp}] Memory usage is still above #{threshold}%. Restarting Palworld server..."

    # reboot script
    eval File.read("./reboot.rb")
  end
else
  puts "[#{timestamp}] Memory usage is below #{threshold}%. No action required."
end
