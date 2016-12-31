require 'yaml'

# Config telegram token url and password with login
module Configurations
  config_file = YAML.load(IO.read('config/config.yml'))

  TELEGRAM_TOKEN = config_file['data']['telegram']['token']
  PASSWORD = config_file['data']['users']['hurzhii']['password']
  LOGIN = config_file['data']['users']['hurzhii']['login']
  URL = config_file['data']['url']
  HELP = config_file['data']['help']
end
