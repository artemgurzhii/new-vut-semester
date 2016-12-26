require './lib/request'

RSpec.describe Data do
  context 'Request should login and return node elements count' do
		it 'Count of "<" should be 953' do
			expect(Data.request).to eq(953)
		end
  end
end
