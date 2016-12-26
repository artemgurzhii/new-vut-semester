require 'openssl'
require 'net/http'
require './lib/yaml_parser'

class Data
	def self.request
		uri = URI(Configurations::URL)
		Net::HTTP.start(uri.host, uri.port,
	  :use_ssl => uri.scheme == 'https',
	  :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|
		  request = Net::HTTP::Get.new uri.request_uri
		  request.basic_auth(Configurations::LOGIN, Configurations::PASSWORD)
		  response = http.request(request)
			return response.body.scan(/</).count
		end
	end
end
