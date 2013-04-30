class FestivalYearsController < ApplicationController
  def index
    @festivals = FestivalYear.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @festivals }
    end
  end
end
