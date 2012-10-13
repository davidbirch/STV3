class RegionsController < ApplicationController
  
  # GET /regions
  # GET /regions.json
  def index
    @regions = Region.all
       
    @title = "Sport on Television in Australia"
    @meta_keywords = "sport, television, tv, coverage, tonight, Australia, Melbourne, Sydney, Brisbane, Adalaide, Perth"
    @meta_description = "Your source for sport on television in Australia.  Find out when sport is on Free-to-air or Pay TV.  Watch live sport on TV tonight."
    @meta_author = "contact@sportontv.com.au"
    
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @regions }
    end
  end

  # GET /regions/1
  # GET /regions/1.json
  def show
    @region = Region.find(params[:id])
    
    querystring = "
    SELECT programs.title, programs.subtitle, programs.description, channels.channel_name, programs.start_datetime, programs.end_datetime
    FROM programs
    LEFT JOIN channels 
    ON programs.channel_id = channels.id
    WHERE programs.end_datetime >= NOW()
    AND programs.region_name = '#{params[:id]}'
    AND programs.sport_name = 'Cricket'
    ORDER BY programs.channel_xmltv_id
    "
       
    @current_programs = Region.find_by_sql(querystring)
      
    @title = "Sport on Television in #{@region.region_name}, Australia"
    @meta_keywords = "sport, television, tv, coverage, tonight, Australia, Melbourne, Sydney, Brisbane, Adalaide, Perth"
    @meta_description = "Your source for sport on television in #{@region.region_name}, Australia.  Find out when sport is on Free-to-air or Pay TV.  Watch live sport on TV tonight."
    @meta_author = "contact@sportontv.com.au"
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @region }
    end
  end

end
