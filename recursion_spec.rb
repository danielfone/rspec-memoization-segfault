require 'rspec'

describe 'A recursive memoized helper' do
  let(:foo) { foo }

  # This passes in ruby < 2.1 and segfaults in ruby >= 2.1
  it 'should raise SystemStackError: stack level too deep' do
    expect { foo }.to raise_error SystemStackError
  end
end
