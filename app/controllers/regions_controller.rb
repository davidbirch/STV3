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
