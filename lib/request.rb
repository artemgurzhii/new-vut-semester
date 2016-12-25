#!/usr/bin/env ruby

require 'openssl'
require 'net/http'
require 'nokogiri'
require_relative 'yaml_parser'

# Прокси с разных айпишников
def request
	uri = URI(Configurations::URL)
	Net::HTTP.start(uri.host, uri.port,
	  :use_ssl => uri.scheme == 'https',
	  :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|

	  request = Net::HTTP::Get.new uri.request_uri
	  request.basic_auth Configurations::LOGIN, Configurations::PASSWORD
	  response = http.request request

		# doc = Nokogiri::HTML(open(Configurations::URL))
		# puts doc.xpath('//*[@class="coprint"]')
		puts response.body.xpath('//*[@class="red"]')
		puts response.body
	end
end

# doc = Nokogiri::HTML(open(url))
# response.body.xpath('//*[@class="red"]')
