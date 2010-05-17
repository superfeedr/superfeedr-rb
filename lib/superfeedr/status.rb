require 'date'

module Superfeedr
  class Status < Blather::XMPPNode
    NS = 'http://superfeedr.com/xmpp-pubsub-ext'.freeze

    def self.parse(node)
      self.new('status').inherit node.find_first('//ns:status', :ns => NS)
    end

    def failed?
      false
    end

    def feed
      self[:feed]
    end

    def code
      self.http_node[:code].to_i
    end

    def http
      self.http_node.content
    end

    def next_fetch
      if next_fetch = self.find_first('//ns:next_fetch', :ns => NS).content
        DateTime.parse next_fetch
      end
    end

  protected
    def http_node
      self.find_first('//ns:http', :ns => NS)
    end
  end
end
