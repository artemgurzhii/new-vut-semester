require 'dotenv/load'
require 'yaml'

# Load data from config file and set variables
module Config
  config = YAML.safe_load(IO.read('config/config.yml'))['messages']

  TELEGRAM_TOKEN = ENV['TELEGRAM_TOKEN']
  PASSWORD = ENV['LOGIN_PASSWORD']
  LOGIN = ENV['LOGIN_NAME']
  CHAT_ID = ENV['CHAT_ID']
  URL = ENV['URL']
  HELP = config['help']
end
