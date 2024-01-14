require 'spec_helper.rb'

describe 'AMQP::VERSION' do
  subject { AMQP::VERSION }
  let(:expected_version) { '1.8.0' }
  it 'returns the expected version' do 
    expect(subject).to eql(expected_version) 
  end
end
