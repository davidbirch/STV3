puts "--- Starting  ---"

# required libraries
require 'rubygems'
require 'feedzirra'

# fetching a single feed
feed_uri = "http://au.news.search.yahoo.com/news/rss?p=sport"
feed = Feedzirra::Feed.fetch_and_parse(feed_uri)
puts feed

puts "-----------------"
# feed and entries accessors
puts feed.title          # => "Paul Dix Explains Nothing"
puts feed.url            # => "http://www.pauldix.net"
puts feed.feed_url       # => "http://feeds.feedburner.com/PaulDixExplainsNothing"
puts feed.etag           # => "GunxqnEP4NeYhrqq9TyVKTuDnh0"
puts feed.last_modified  # => Sat Jan 31 17:58:16 -0500 2009 # it's a Time object
puts "-----------------"

puts feed.entries
puts "-----------------"
entry = feed.entries.first
puts entry.title      # => "Ruby Http Client Library Performance"
puts entry.url        # => "http://www.pauldix.net/2009/01/ruby-http-client-library-performance.html"
puts entry.summary    # => "..."


puts "--- Completed ---"

