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
    bot.api.send_message(
      chat_id: chat.id,
      text: text,
      reply_markup: reply_markup
    )
    logger.debug "sending #{text} to #{chat.username}"
  end

  private

  def reply_markup
    ReplyMarkupFormatter.new(answers).markup if answers
  end
end
