#!/usr/bin/env ruby

require 'openssl'
require 'nokogiri'
require 'net/http'
require 'nokogiri'
require 'fileutils'

def compare_output
	begin
		x = FileUtils.compare_file('index.html', 'current.html')
		puts x
	rescue => err
    puts "Exception: #{err}"
    err
	end
end

def request
	uri = URI('https://wis.fit.vutbr.cz/FIT/st/course-reg.php.cs')
	Net::HTTP.start(uri.host, uri.port,
	  :use_ssl => uri.scheme == 'https',
	  :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|

	  request = Net::HTTP::Get.new uri.request_uri
	  request.basic_auth 'xhurzh00', 'pumduj6are'
	  response = http.request request
		# puts response.body
		File.write('current.html', response.body)
		# unless compare_output()
		# 	send_message('')
		# end
	end
end

request()
