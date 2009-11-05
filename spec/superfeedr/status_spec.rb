require 'spec_helper'

# <status xmlns="http://superfeedr.com/xmpp-pubsub-ext" feed="http://superfeedr.com/dummy.xml">
#   <http code="200">957 bytes fetched in 0.228013s</http>
#   <next_fetch>2009-11-05T16:34:12+00:00</next_fetch>
# </status>

describe Superfeedr::Status do
  before do
    @status = Superfeedr::Status.parse message_node
  end

  it 'knows the feed it belongs to' do
    @status.feed.must_equal 'http://superfeedr.com/dummy.xml'
  end

  it 'knows its status code' do
    @status.code.must_equal 200
  end

  it 'has more info about the http code' do
    @status.http.must_equal '957 bytes fetched in 0.228013s'
  end

  it 'knows when the next fetch will be' do
    @status.next_fetch.must_equal DateTime.parse('2009-11-05T16:34:12+00:00')
  end
end
