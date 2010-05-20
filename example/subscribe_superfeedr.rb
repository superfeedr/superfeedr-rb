require 'superfeedr-rb'
channel = EM::Channel.new

Thread.new do
  Superfeedr::Client.connect('login@superfeedr.com', 'pwd', :subscribe_channel => channel ) do |client|
    client.register_handler(:pubsub_event) do |evt|
      pp evt
    end

    client.register_handler(:disconnected){ client.connect }
  end
end

sleep 10
channel.push('http://github.com/shingara.atom')
sleep 10
