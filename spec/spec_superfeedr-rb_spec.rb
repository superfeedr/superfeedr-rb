require 'spec_helper'

describe Superfeedr::Client do
  it 'should it herited Blater::Client' do
    Superfeedr::Client.new.must_be_kind_of Blather::Client
  end

  describe '#initialize' do
    it 'should initialize deferred attribute like array' do
      client = Superfeedr::Client.new
      client.instance_variable_get(:@deferred).must_equal []
    end
  end

  describe '#subscribe' do
    it 'should write Subscribe' do
      client = Superfeedr::Client.setup 'login@superfeedr.com', 'pass'
      mock_stanza = mock()
      Blather::Stanza::PubSub::Subscribe.expects(:new).returns(mock_stanza)
      client.expects(:write).with(mock_stanza)
      client.subscribe('http://github.com/shingara.atom')
    end
  end

end
