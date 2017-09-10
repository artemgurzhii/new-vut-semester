require 'logger'
require './lib/yaml_parser'

# setting up app by providing telegram token and logger settings
class AppConfigurator
  def token
    Config::TELEGRAM_TOKEN
  end

  def logger
    Logger.new(STDOUT, Logger::DEBUG)
  end
end
