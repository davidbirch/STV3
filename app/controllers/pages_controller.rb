class PagesController < ApplicationController
  
  before_filter :authenticate, :except => [:about, :privacy, :contact]
    
  def about
    @title = "About | Sport on Television in Australia"
    @breadcrumb = "About"
    @meta_keywords = "sport, television, tv, coverage, tonight, Australia, Melbourne, Sydney, Brisbane, Adalaide, Perth"
    @meta_description = "Your source for sport on television in Australia.  Find out when sport is on Free-to-air or Pay TV.  Watch live sport on TV tonight."
    @meta_author = "contact@sportontv.com.au"
    @regions = Region.all
        
    # fetching a single feed
    feed_uri = "http://au.news.search.yahoo.com/news/rss?p=sport"
    news_feed = Feedzirra::Feed.fetch_and_parse(feed_uri)
    @news_entries = news_feed.entries  
    
  end

  def privacy
    @title = "Privacy Statement | Sport on Television in Australia"
    @breadcrumb = "Privacy"
    @meta_keywords = "sport, television, tv, coverage, tonight, Australia, Melbourne, Sydney, Brisbane, Adalaide, Perth"
    @meta_description = "Your source for sport on television in Australia.  Find out when sport is on Free-to-air or Pay TV.  Watch live sport on TV tonight."
    @meta_author = "contact@sportontv.com.au"
    @regions = Region.all
        
    # fetching a single feed
    feed_uri = "http://au.news.search.yahoo.com/news/rss?p=sport"
    news_feed = Feedzirra::Feed.fetch_and_parse(feed_uri)
    @news_entries = news_feed.entries  
    
  end

  def contact
    @title = "Contact Us | Sport on Television in Australia"
    @breadcrumb = "Contact"
    @meta_keywords = "sport, television, tv, coverage, tonight, Australia, Melbourne, Sydney, Brisbane, Adalaide, Perth"
    @meta_description = "Your source for sport on television in Australia.  Find out when sport is on Free-to-air or Pay TV.  Watch live sport on TV tonight."
    @meta_author = "contact@sportontv.com.au"
    @regions = Region.all
        
    # fetching a single feed
    feed_uri = "http://au.news.search.yahoo.com/news/rss?p=sport"
    news_feed = Feedzirra::Feed.fetch_and_parse(feed_uri)
    @news_entries = news_feed.entries  
    
  end
  
  def login
    @title = "Login | Sport on Television in Australia"
    @breadcrumb = "Login"
    @meta_keywords = "sport, television, tv, coverage, tonight, Australia, Melbourne, Sydney, Brisbane, Adalaide, Perth"
    @meta_description = "Your source for sport on television in Australia.  Find out when sport is on Free-to-air or Pay TV.  Watch live sport on TV tonight."
    @meta_author = "contact@sportontv.com.au"
    @regions = Region.all
        
    # fetching a single feed
    feed_uri = "http://au.news.search.yahoo.com/news/rss?p=sport"
    news_feed = Feedzirra::Feed.fetch_and_parse(feed_uri)
    @news_entries = news_feed.entries  
    
  end
  
  def dashboard
    @title = "Dashboard | Sport on Television in Australia"
    @breadcrumb = "Dashboard"
    @meta_keywords = "sport, television, tv, coverage, tonight, Australia, Melbourne, Sydney, Brisbane, Adalaide, Perth"
    @meta_description = "Your source for sport on television in Australia.  Find out when sport is on Free-to-air or Pay TV.  Watch live sport on TV tonight."
    @meta_author = "contact@sportontv.com.au"
    @regions = Region.all
        
    # fetching a single feed
    feed_uri = "http://au.news.search.yahoo.com/news/rss?p=sport"
    news_feed = Feedzirra::Feed.fetch_and_parse(feed_uri)
    @news_entries = news_feed.entries  
    
  end
end
