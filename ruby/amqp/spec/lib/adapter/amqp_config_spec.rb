require 'spec_helper.rb'

describe 'Adapter::AmqpConfig' do
  describe '::CONNECTION_OPTIONS' do
    subject { Adapter::AmqpConfig::CONNECTION_OPTIONS }
    it 'has default config' do 
      expect(subject[:host]).to eql('localhost') 
      expect(subject[:username]).to eql('guest') 
      expect(subject[:password]).to eql('guest') 
    end
  end
  
  describe '::QUEUE' do
    subject { Adapter::AmqpConfig::QUEUE }
    it 'has default config' do 
      expect(subject).to eql('lck.amqp.example') 
    end
  end
end
