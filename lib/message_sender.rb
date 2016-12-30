require './lib/reply_markup_formatter'
require './lib/app_configurator'

# send message to user
class MessageSender
  attr_reader :bot, :text, :chat, :answers, :logger

  def initialize(options)
    @bot = options[:bot]
    @text = options[:text]
    @chat = options[:chat]
    @answers = options[:answers]
    @logger = AppConfigurator.new.logger
  end

  def send
    if reply_markup
      bot.api.send_message(data)
    else
      bot.api.send_message(data(false))
    end
    logger.debug "sending #{text} to #{chat.username}"
  end

  private

  def data(reply = true)
    if reply
      { chat_id: chat.id, text: text, reply_markup: reply_markup }
    else
      { chat_id: chat.id, text: text }
    end
  end

  def reply_markup
    ReplyMarkupFormatter.new(answers).markup if answers
  end
end
