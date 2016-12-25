#!/usr/bin/env ruby

require 'telegram/bot'
require_relative 'lib/request'
require_relative 'lib/yaml_parser'

Telegram::Bot::Client.run(Configurations::TELEGRAM_TOKEN) do |bot|
  bot.listen do |message|
    case message.text
		when '/now'
			if request == 953
				bot.api.sendMessage(chat_id: message.chat.id, text: "Nothing has changed")
			elsif request.between?(940, 963)
				bot.api.sendMessage(chat_id: message.chat.id, text: "I have noticed minor changes, but it doesn't look like registrations has starterd")
			else
				bot.api.sendMessage(chat_id: message.chat.id, text: "Go check #{Configurations::URL}, it's look like registration has started.")
			end

		when '/exams'
			exam_result = rand(10) > 5 ? 'pass' : 'fail'
			bot.api.sendMessage(chat_id: message.chat.id, text: "Hi #{message.from.first_name}! I think you will #{exam_result} this test.")

		when '/help'
			bot.api.sendMessage(chat_id: message.chat.id, text: "Hi, I'm bot which will help you not to expelled from the university. I'm checking VUT website, and as soon you can register, I will reming you. You are able to use next commands:
				\t/now - get current registration status
				\t/exams - my opinion on your test results
				\t/help - read info one more time")
    end
  end
end
