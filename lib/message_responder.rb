require './lib/message_sender'
require './lib/yaml_parser'
require './lib/request'

# create new message based on the received message
class MessageResponder
  attr_reader :message, :bot

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
  end

  def respond
    on(/\/start/) do
      start
    end

    on(/\/now/) do
      now
    end

    on(/\/exams/) do
      exams
    end

    on(/\/help/) do
      help
    end

    on(/\/nodes/) do
      nodes
    end
  end

  private

    def on(regex, &block)
      yield if regex =~ message.text && block.arity.zero?
    end

    def start
      answer_with_message(
        'Привет, меня зовут NewVutSemesterBot,' \
        'и я помогу вам не вылететь из вуза!'
      )
    end

    def now
      nodes = Data.request
      if nodes == 953
        answer_with_message('Регистрация еще не началась')
      else
        answer_with_message(
          "Быстро перейдите на #{Config::URL}" \
          ', регистрация скорее всего началась!!!'
        )
      end
    end

    def nodes
      answer_with_message(
        "Количество дом элементов раньше было 953. Сейчас их #{Data.request}"
      )
    end

    def exams
      exam_result = rand(2) > 1 ? 'сдашь' : 'завалишь'
      answer_with_message(
        "Привет #{message.from.first_name}! Я думаю ты #{exam_result} этот тест."
      )
    end

    def help
      answer_with_message(Config::HELP)
    end

    def answer_with_message(text)
      MessageSender.new(bot: bot, chat: message.chat, text: text).send
    end
end
