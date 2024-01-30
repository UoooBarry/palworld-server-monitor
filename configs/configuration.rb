require 'yaml'

class ConfigError < StandardError; end

def configuration
  config = YAML.load_file('configs/settings.yml')

  if !config.dig("services", "palworld_service") || config.dig("services", "palworld_service").empty?
    raise ConfigError, 'palworld_service is missing.'
  end

  config
end
