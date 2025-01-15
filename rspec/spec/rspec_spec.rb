RSpec.describe 'Hook Test' do
  before { puts 'Running before each test' }
  after { puts 'Running after each test' }

  let(:number) { 42 }
end
