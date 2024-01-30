# frozen_string_literal: true

require 'yaml'

class ConfigError < StandardError; end

def configuration
  config = YAML.load_file('configs/settings.yml')

  raise ConfigError, 'palworld_service is missing.' if config.dig('services', 'palworld_service').blank?

  config
end
