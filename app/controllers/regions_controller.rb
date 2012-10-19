class RegionsController < ApplicationController
  
  # GET /regions
  # GET /regions.json
  def index

    @title = "Sport on Television in Australia"
    @meta_keywords = "sport, television, tv, coverage, tonight, Australia, Melbourne, Sydney, Brisbane, Adalaide, Perth"
    @meta_description = "Your source for sport on television in Australia.  Find out when sport is on Free-to-air or Pay TV.  Watch live sport on TV tonight."
    @meta_author = "contact@sportontv.com.au"
    @regions = Region.all
        
    # fetching a single feed
    feed_uri = "http://au.news.search.yahoo.com/news/rss?p=sport"
    news_feed = Feedzirra::Feed.fetch_and_parse(feed_uri)
    @news_entries = news_feed.entries  
        
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /regions/1
  # GET /regions/1.json
  def show
    @region = Region.find(params[:id])
    
    querystring = "
    SELECT DISTINCT programs.title, programs.subtitle, programs.sport_name, channels.channel_name, channels.channel_short_name,
           DATE_FORMAT(programs.start_datetime,'%a, %d %b %Y') AS start_day, programs.start_datetime,
           programs.end_datetime, DATE_FORMAT(programs.start_datetime,'%k:%i') AS start_time,
           DATE_FORMAT(programs.end_datetime,'%k:%i') AS end_time
    FROM programs
    LEFT JOIN channels 
    ON programs.channel_id = channels.id
    WHERE programs.end_datetime >= NOW()
    AND programs.region_name = '#{params[:id]}'
    ORDER BY start_datetime ASC, end_datetime ASC, channel_name ASC, subtitle DESC, title DESC
    "
       
    @current_programs = Region.find_by_sql(querystring)
      
    @title = "Sport on Television in #{@region.region_name}, Australia"
    @meta_keywords = "sport, television, tv, coverage, tonight, Australia, Melbourne, Sydney, Brisbane, Adalaide, Perth"
    @meta_description = "Your source for sport on television in #{@region.region_name}, Australia.  Find out when sport is on Free-to-air or Pay TV.  Watch live sport on TV tonight."
    @meta_author = "contact@sportontv.com.au"
    @regions = Region.all
    @sports = Sport.all
    
    # fetching a single feed
    feed_uri = "http://au.news.search.yahoo.com/news/rss?p=sport"
    news_feed = Feedzirra::Feed.fetch_and_parse(feed_uri)
    @news_entries = news_feed.entries  
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end

end
