#!/usr/bin/env ruby

require 'telegram/bot'
require_relative 'lib/compare'
require_relative 'lib/request'
require_relative 'lib/yaml_parser'

# doc = Nokogiri::HTML(open(url))
# doc.xpath('.//*[class="red"]')

Telegram::Bot::Client.run(Configurations::TELEGRAM_TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.sendMessage(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
		when '/now'
			bot.api.sendMessage(chat_id: message.chat.id, text: compare_output)
		when '/help'
			bot.api.sendMessage(chat_id: message.chat.id, text: "Hi, I'm bot which will help you not to expelled from the university. I'm checking VUT website, and as soon you can register, I will reming you. You are able to use next commands:
				\t/now - get current registration status
				\t/exams - my opinion on your test results
				\t/help - read info one more time")
		when '/exams'
			exam_result = rand(10) > 5 ? 'pass' : 'fail'
			bot.api.sendMessage(chat_id: message.chat.id, text: "Hi #{message.from.first_name}! I think you will #{exam_result} this test.")
    end
  end
end
request()
