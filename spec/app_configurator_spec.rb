require './lib/app_configurator'
require './lib/yaml_parser'

token = AppConfigurator.new.get_token
TELEGRAM_TOKEN = YAML::load(IO.read('config/config.yml'))['data']['telegram']['token']

RSpec.describe AppConfigurator do
  context 'getter for telegram token' do
		it 'getter for telegram token' do
			expect(token).to eq(TELEGRAM_TOKEN)
		end
  end
end
