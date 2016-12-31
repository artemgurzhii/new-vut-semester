require 'openssl'
require 'net/http'
require './lib/yaml_parser'

# send request and return html string
class Data
  def self.request
    uri = URI(Configurations::URL)
    Net::HTTP.start(
      uri.host, uri.port,
      use_ssl: true,
      verify_mode: OpenSSL::SSL::VERIFY_NONE
    ) do |http|
      request = Net::HTTP::Get.new uri.request_uri
      request.basic_auth(Configurations::LOGIN, Configurations::PASSWORD)
      return http.request(request).body.scan(/</).count
    end
  end
end
