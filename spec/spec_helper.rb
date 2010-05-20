require 'rubygems'
require 'minitest/spec'
require 'mocha'

$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..'))
$:.unshift File.expand_path(File.join(File.dirname(__FILE__), *%w[.. lib]))
require 'superfeedr-rb'

def message_node
  Blather::XMPPNode.import(Nokogiri::XML(<<-XML).root)
    <message from="firehoser.superfeedr.com" to="sprsquish@superfeedr.com">
      <event xmlns="http://jabber.org/protocol/pubsub#event">
        <status xmlns="http://superfeedr.com/xmpp-pubsub-ext" feed="http://superfeedr.com/dummy.xml">
          <http code="200">957 bytes fetched in 0.228013s</http>
          <next_fetch>2009-11-05T16:34:12+00:00</next_fetch>
        </status>
        <items node="http://superfeedr.com/dummy.xml">
          <item xmlns="http://jabber.org/protocol/pubsub" chunks="1" chunk="1">
            <entry xmlns="http://www.w3.org/2005/Atom">
              <title>16:32:41</title>
              <id>tag:superfeedr.com,2005:String/1257438761</id>
              <published>2009-11-05T16:32:41+00:00</published>
              <summary>sprsquish wanted to know what time it was.</summary>
              <content>Thursday November 05 16:32:41 UTC 2009 sprsquish wanted to know what time it was.</content>
              <category term="tag" scheme="http://www.sixapart.com/ns/types#tag" />
              <category term="category" scheme="http://www.sixapart.com/ns/types#tag" />
              <link type="text/html" href="http://superfeedr.com/?1257438761" title="superfeedr" rel="alternate"/>
              <author>
                <name>Superfeedr</name>
                <uri>http://superfeedr.com/</uri>
                <email>julien@superfeedr.com</email>
              </author>
            </entry>
          </item>
        </items>
      </event>
    </message>
  XML
end

MiniTest::Unit.autorun
