require 'logger'
require './lib/yaml_parser'

class AppConfigurator
	def get_token
		Configurations::TELEGRAM_TOKEN
	end

  def get_logger
    Logger.new(STDOUT, Logger::DEBUG)
  end
end
