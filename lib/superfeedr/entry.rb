module Superfeedr
  class Entry < Blather::Stanza::PubSubItem
    NS = 'http://www.w3.org/2005/Atom'.freeze

    def self.parse(node)
      node.find('//ns:event/ns:items/ns2:item', :ns => Blather::Stanza::PubSub::Event.registered_ns,
                                                :ns2 => Blather::Stanza::PubSub.registered_ns).map do |item|
        Entry.new('item').inherit(item)
      end
    end

    def chunks
      self[:chunks].to_i
    end

    def chunk
      self[:chunk].to_i
    end

    def id
      self.entry.content_from 'ns:id', :ns => NS
    end

    def title
      self.entry.content_from 'ns:title', :ns => NS
    end

    def published
      if published = self.entry.content_from('ns:published', :ns => NS)
        DateTime.parse published
      end
    end

    def content
      self.entry.content_from 'ns:content', :ns => NS
    end

    def summary
      self.entry.content_from 'ns:summary', :ns => NS
    end

    def categories
      self.entry.find('ns:category', :ns => NS).map { |cat| cat[:term] }
    end

    def links
      self.entry.find('ns:link', :ns => NS).map { |l| Link.new.inherit(l) }
    end

    def authors
      self.entry.find('ns:author', :ns => NS).map { |l| Author.new.inherit(l) }
    end

    def entry
      Blather::XMPPNode.import(super)
    end

    class Link < Blather::XMPPNode
      def href
        self[:href]
      end

      def rel
        self[:rel]
      end

      def type
        self[:type]
      end

      def title
        self[:title]
      end
    end

    class Author < Blather::XMPPNode
      def name
        self.content_from 'ns:name', :ns => NS
      end

      def email
        self.content_from 'ns:email', :ns => NS
      end

      def uri
        self.content_from 'ns:uri', :ns => NS
      end
    end
  end
end
