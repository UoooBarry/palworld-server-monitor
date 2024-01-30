# frozen_string_literal: true

require 'palworld_rcon'
require_relative './configs/configuration'

config = configuration
if config.dig('rcon_connection', 'enable')
  connection = config.fetch('rcon_connection').symbolize_keys.except(:enable)
  client = PalworldRcon::Client.new(**connection)
  puts 'RCON connect success.'
  client.shutdown(10, 'Server is going to restart after 10 seconds')
  sleep 15
  puts 'RCON shutdown.'
end
`systemctl restart #{config.dig('services', 'palworld_service')}`
