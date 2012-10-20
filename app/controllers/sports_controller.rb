class SportsController < ApplicationController
  
  before_filter :authenticate
  
  # GET /sports/1
  # GET /sports/1.json
  def show
    @sport = Sport.find(params[:id])
    @regions = Region.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sport }
    end
  end

end
