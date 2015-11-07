require 'yaml'

config_file = File.expand_path('../config.yml', File.dirname(__FILE__))
CONFIG_DATA = YAML.load_file(config_file)
