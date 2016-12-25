require 'logger'
require './lib/database_connector'
require './lib/yaml_parser'

class AppConfigurator
  def configure
    # setup_database
		puts 'Test'
  end

  def get_token
    Configurations::TELEGRAM_TOKEN
  end

  def get_logger
    Logger.new(STDOUT, Logger::DEBUG)
  end

  private
	  def setup_database
	    DatabaseConnector.establish_connection
	  end
end
