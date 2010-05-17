module Superfeedr
  module Subscriber

    def initialize(client)
      @client = client
    end

    def receive_data data
      if data =~ /subscribe:(.*)/
        url = $1
        @client.write Blather::Stanza::PubSub::Subscribe.new(:set, 'firehoser.superfeedr.com', url, @client.jid.stripped)
        send_data "subscribe OK"
      end
    end

  end
end
