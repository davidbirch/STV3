class RulesController < ApplicationController
  
  before_filter :authenticate
  
  # GET /rules
  # GET /rules.json
  def index
    @title = "Rules | Sport on Television in Australia"
    @breadcrumb = "Rules"
    @meta_keywords = "sport, television, tv, coverage, tonight, Australia, Melbourne, Sydney, Brisbane, Adalaide, Perth"
    @meta_description = "Your source for sport on television in Australia.  Find out when sport is on Free-to-air or Pay TV.  Watch live sport on TV tonight."
    @meta_author = "contact@sportontv.com.au"
    @regions = Region.all
        
    # fetching a single feed
    feed_uri = "http://au.news.search.yahoo.com/news/rss?p=sport"
    news_feed = Feedzirra::Feed.fetch_and_parse(feed_uri)
    @news_entries = news_feed.entries  
    
    
    #get the rules sorted aligned to the algorithm
    querystring = "
    SELECT id, rule_type, priority, value, sport_name, created_at, updated_at, channel_xmltv_id, LENGTH(value) AS value_length, DATE(updated_at) = DATE(NOW()) AS updated_today
    FROM rules
    ORDER BY rule_type, priority DESC, value_length DESC
    "    
    @rules = Rule.find_by_sql(querystring)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rules }
    end
  end

  # GET /rules/1
  # GET /rules/1.json
  def show
    @rule = Rule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rule }
    end
  end

  # GET /rules/new
  # GET /rules/new.json
  def new
    @rule = Rule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rule }
    end
  end

  # GET /rules/1/edit
  def edit
    @rule = Rule.find(params[:id])
  end

  # POST /rules
  # POST /rules.json
  def create
    @rule = Rule.new(params[:rule])

    respond_to do |format|
      if @rule.save
        format.html { redirect_to @rule, notice: 'Rule was successfully created.' }
        format.json { render json: @rule, status: :created, location: @rule }
      else
        format.html { render action: "new" }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rules/1
  # PUT /rules/1.json
  def update
    @rule = Rule.find(params[:id])

    respond_to do |format|
      if @rule.update_attributes(params[:rule])
        format.html { redirect_to @rule, notice: 'Rule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rules/1
  # DELETE /rules/1.json
  def destroy
    @rule = Rule.find(params[:id])
    @rule.destroy

    respond_to do |format|
      format.html { redirect_to rules_url }
      format.json { head :no_content }
    end
  end
end
