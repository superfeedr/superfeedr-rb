require 'rubygems'
require 'superfeedr-rb'
require 'pp'

Blather.logger.level = Logger::DEBUG
Superfeedr::Client.connect('n@d/r', 'password') do |client|
  # Automatically subscribes to the feed
  # If already subscribed it simply catches the events coming in.
  client.feed('http://superfeedr.com/dummy.xml') do |status, entries|
    return if status.failed?
    pp({
      :status => {
        :feed => status.feed,
        :code => status.code,
        :http => status.http,
        :next_fetch => status.next_fetch
      },
      :entries => entries.map { |entry| {
        :id => entry.id,
        :chunks => entry.chunks,
        :chunk => entry.chunk,
        :title => entry.title,
        :published => entry.published,
        :content => entry.content,
        :summary => entry.summary,
        :categories => entry.categories,
        :links => entry.links.map { |link| {
          :href => link.href,
          :rel => link.rel,
          :type => link.type,
          :title => link.title
        }},
        :authors => entry.authors.map { |author| {
          :name => author.name,
          :email => author.email,
          :uri => author.uri
        }}
      }}
    })
  end

  # client.feed('http://github.com/superfeedr.atom') do |notification|
  #   pp notification
  # end

  # Catch all notifications
  # This works because Superfeedr::Client is just a subsclass of Blather::Client
  client.register_handler(:pubsub_event) do |evt|
    pp evt
  end
end
