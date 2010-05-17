require 'socket'
s = UNIXSocket.new('/tmp/superfeedr.sock')
s.write('subscribe:http://github.com/shingara.atom')
s.close
