require 'openssl'
require 'net/http'
require './lib/yaml_parser'

# send request, parse html as string and return '<' elements count
class Data
  def self.request
    uri = URI(Config::URL)
    Net::HTTP.start(
      uri.host, uri.port,
      use_ssl: true,
      verify_mode: OpenSSL::SSL::VERIFY_NONE
    ) do |http|
      request = Net::HTTP::Get.new uri.request_uri
      request.basic_auth(Config::LOGIN, Config::PASSWORD)

      http.request(request).body.scan(/</).count
    end
  end
end
