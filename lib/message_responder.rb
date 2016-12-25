require './models/user'
require './lib/message_sender'
require './lib/request'
require './lib/yaml_parser'

class MessageResponder
  attr_reader :message
  attr_reader :bot
  attr_reader :user

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
    @user = User.find_or_create_by(uid: message.from.id)
  end

  def respond
    on /^\/start/ do
      greeting
    end

		on /^\/now/ do
			current_registration_status
		end

		on /^\/exams/ do
			exams
		end

		on /^\/help/ do
			help
		end
  end

  private

	  def on regex, &block
	    regex =~ message.text

	    if $~
	      case block.arity
	      when 0
	        yield
	      when 1
	        yield $1
	      when 2
	        yield $1, $2
	      end
	    end
	  end

		def greeting
	    answer_with_message "Привет, меня зовут NewVutSemesterBot, и я помогу вам не вылететь из вуза!"
	  end

		def current_registration_status
			if request == 953
				answer_with_message "Регистрация еще не началась"
			elsif request.between?(940, 963)
				answer_with_message "Я заметил небольшие изменения, но вероятнее всего регистрация еще не началась."
			else
				answer_with_message "Быстро перейдите на #{Configurations::URL}, регистрация скорее всего началась!!!"
			end
		end

		def exams
			exam_result = rand(10) > 5 ? 'сдашь' : 'завалишь'
			answer_with_message "Привет #{message.from.first_name}! Я думаю ты #{exam_result} этот тест."
		end

		def help
			answer_with_message "Привет, я бот который поможет тебе не вылететь из вуза. Я проверяю каждые 5 минут сайт VUT, и как только там появится регистрация на следующий семестр, я вам напишу. Вы можете использовать следующие команды:
				\t/now - получить нынешний статус регистрации
				\t/exams - мое мнение на то, как вы сдадите экзамены
				\t/help - прочитать информацию еще раз
В будущем, я планирую стать умнее и иметь возможность отвечать на все ваши вопросы связанные с учебой в этом вузе."
		end

	  def answer_with_message(text)
	    MessageSender.new(bot: bot, chat: message.chat, text: text).send
	  end
end
