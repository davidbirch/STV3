class ProgramsController < ApplicationController
  # GET /programs
  # GET /programs.json
  def index
    
    @region = Region.find_by_region_name(params[:region])
    @sport = Sport.find_by_sport_name(params[:sport])
    
    querystring = "
    SELECT DISTINCT programs.title, programs.subtitle, programs.sport_name, channels.channel_name, channels.channel_short_name,
           DATE_FORMAT(programs.start_datetime,'%a, %d %b %Y') AS start_day, programs.start_datetime,
           programs.end_datetime, DATE_FORMAT(programs.start_datetime,'%k:%i') AS start_time,
           DATE_FORMAT(programs.end_datetime,'%k:%i') AS end_time
    FROM programs
    LEFT JOIN channels 
    ON programs.channel_id = channels.id
    WHERE programs.end_datetime >= NOW()
    AND programs.region_name = '#{params[:region]}'
    AND programs.sport_name = '#{params[:sport]}'
    ORDER BY start_datetime ASC, end_datetime ASC, channel_name ASC, subtitle DESC, title DESC
    "
       
    @current_programs = Region.find_by_sql(querystring)
      
    @title = "#{@sport.sport_name} on Television in #{@region.region_name}, Australia"
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
      format.html # index.html.erb
      format.json { render json: @programs }
    end
  end


  # GET /programs/1
  # GET /programs/1.json
  def show
    @program = Program.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @program }
    end
  end

  # GET /programs/new
  # GET /programs/new.json
  def new
    @program = Program.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @program }
    end
  end

  # GET /programs/1/edit
  def edit
    @program = Program.find(params[:id])
  end

  # POST /programs
  # POST /programs.json
  def create
    @program = Program.new(params[:program])

    respond_to do |format|
      if @program.save
        format.html { redirect_to @program, notice: 'Program was successfully created.' }
        format.json { render json: @program, status: :created, location: @program }
      else
        format.html { render action: "new" }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /programs/1
  # PUT /programs/1.json
  def update
    @program = Program.find(params[:id])

    respond_to do |format|
      if @program.update_attributes(params[:program])
        format.html { redirect_to @program, notice: 'Program was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programs/1
  # DELETE /programs/1.json
  def destroy
    @program = Program.find(params[:id])
    @program.destroy

    respond_to do |format|
      format.html { redirect_to programs_url }
      format.json { head :no_content }
    end
  end
end
