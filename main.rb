#!/usr/bin/env ruby

require 'openssl'
require 'nokogiri'
require 'net/http'
require 'nokogiri'
require 'fileutils'
require 'telegram/bot'

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

token = '281271685:AAGD0YznrFPbh6Xgt37V_SRwg1EXUaXddzA'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.sendMessage(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
		when '/now'
			bot.api.sendMessage(chat_id: message.chat.id, text: compare_output)
    end
  end
end
request()
