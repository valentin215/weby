RSpec.describe 'Array' do
  let(:array) { [1, 2, 3] }

  before do
    puts 'Running setup before each test'
  end

  after do
    puts 'Running teardown after each test'
  end

  it 'has the correct size' do
    expect(array.size).to(eq(3))
  end

  it 'contains the number 2' do
    expect(array.include?(2)).to(eq(true))
  end

  it 'can be appended to' do
    array << 4
    expect(array.size).to(eq(5))
  end

  it 'is not empty' do
    expect(array).not_to(be_empty)
  end
end
