require 'yaml'

module Configurations
	config_file = YAML::load(IO.read('config/config.yml'))

	TELEGRAM_TOKEN = config_file['data']['telegram']['token']
	LOGIN = config_file['data']['users']['hurzhii']['login']
	PASSWORD = config_file['data']['users']['hurzhii']['password']
	URL = config_file['data']['url']
end
