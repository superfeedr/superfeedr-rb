require 'spec_helper'

# <item chunks="1" chunk="1">
#   <entry xmlns="http://www.w3.org/2005/Atom">
#     <title>16:32:41</title>
#     <id>tag:superfeedr.com,2005:String/1257438761</id>
#     <published>2009-11-05T16:32:41+00:00</published>
#     <summary>sprsquish wanted to know what time it was.</summary>
#     <content>Thursday November 05 16:32:41 UTC 2009 sprsquish wanted to know what time it was.</content>
#     <category term="tag" scheme="http://www.sixapart.com/ns/types#tag" />
#     <category term="category" scheme="http://www.sixapart.com/ns/types#tag" />
#     <link type="text/html" href="http://superfeedr.com/?1257438761" title="superfeedr" rel="alternate"/>
#     <author>
#       <name>Superfeedr</name>
#       <uri>http://superfeedr.com/</uri>
#       <email>julien@superfeedr.com</email>
#     </author>
#   </entry>
# </item>

describe Superfeedr::Entry do
  before do
    @events = Superfeedr::Entry.parse message_node
    @event = @events.first
  end

  it 'parses apart a list of items' do
    @events.must_be_kind_of Array
    @events.size.must_equal 1
  end

  it 'knows how many chunks it has' do
    @event.chunks.must_equal 1
  end

  it 'knows what chunk it is' do
    @event.chunk.must_equal 1
  end

  it 'knows its title' do
    @event.title.must_equal '16:32:41'
  end

  it 'knows its id' do
    @event.id.must_equal 'tag:superfeedr.com,2005:String/1257438761'
  end

  it 'knows when it was published' do
    @event.published.must_equal DateTime.parse('2009-11-05T16:32:41+00:00')
  end

  it 'has content' do
    @event.content.must_equal 'Thursday November 05 16:32:41 UTC 2009 sprsquish wanted to know what time it was.'
  end

  it 'has a summary' do
    @event.summary.must_equal 'sprsquish wanted to know what time it was.'
  end

  it 'knows its categories' do
    @event.categories.must_equal %w[tag category]
  end

  it 'has a set of links' do
    @event.links.size.must_equal 1
    @event.links.first.must_be_kind_of Superfeedr::Entry::Link
  end

  it 'has a set of authors' do
    @event.authors.size.must_equal 1
    @event.authors.first.must_be_kind_of Superfeedr::Entry::Author
  end
end

# <link type="text/html" href="http://superfeedr.com/?1257438761" title="superfeedr" rel="alternate"/>
describe Superfeedr::Entry::Link do
  before do
    @link = Superfeedr::Entry.parse(message_node).first.links.first
  end

  it 'knows its href' do
    @link.href.must_equal 'http://superfeedr.com/?1257438761'
  end

  it 'knows its rel' do
    @link.rel.must_equal 'alternate'
  end

  it 'knows its type' do
    @link.type.must_equal 'text/html'
  end

  it 'knows its title' do
    @link.title.must_equal 'superfeedr'
  end
end

# <author>
#   <name>Superfeedr</name>
#   <uri>http://superfeedr.com/</uri>
#   <email>julien@superfeedr.com</email>
# </author>
describe Superfeedr::Entry::Author do
  before do
    @author = Superfeedr::Entry.parse(message_node).first.authors.first
  end

  it 'knows its name' do
    @author.name.must_equal 'Superfeedr'
  end

  it 'knows its uri' do
    @author.uri.must_equal 'http://superfeedr.com/'
  end

  it 'knows its email' do
    @author.email.must_equal 'julien@superfeedr.com'
  end
end
