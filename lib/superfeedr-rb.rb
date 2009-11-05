%w[
  blather
  blather/client/client

  superfeedr/entry
  superfeedr/status
].each { |r| require r }

module Superfeedr

  class Client < Blather::Client
    def self.connect(jid, pass, host = nil, port = nil)
      if block_given?
        client = self.setup jid, pass, host, port
        EM.run {
          yield client
          client.connect
        }
      else
        super
      end
    end

    def initialize # :nodoc:
      super
      @deferred = []
    end

    def feed(url, &block)
      return if defer(:feed, url, &block)
      self.write Blather::Stanza::PubSub::Subscribe.new(:set, 'firehoser.superfeedr.com', url, self.jid.stripped)

      self.register_handler(:pubsub_event, "//ns:items[@node='#{url}']", :ns => Blather::Stanza::PubSub::Event.registered_ns) do |evt, _|
        block.call Status.parse(evt), Entry.parse(evt)
      end
    end

    def client_post_init # :nodoc:
      # overwrite the default actions to take after a client is setup
      status = Blather::Stanza::Presence::Status.new
      status.priority = 100
      write status
    end

    # Allow users to setup callbacks before the connection is setup
    def defer(*args, &block) # :nodoc:
      if @stream
        false
      else
        @deferred << [args, block]
        true
      end
    end

    # Run all deferred commands after the connection is established
    def post_init(stream, jid = nil) # :nodoc:
      super
      until @deferred.empty?
        args = @deferred.pop
        self.__send__ *(args[0]), &args[1]
      end
    end
  end

end
