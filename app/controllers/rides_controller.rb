class RidesController < ApplicationController
  before_filter :load_rideable
  before_filter :authenticate_user!, :except => :index

  def index
    @rides = @rideable.rides
  end

  def show
    @ride = @rideable.rides.find(params[:id])

  end

  def new
    @ride = Ride.new
  end

  def create
    @ride = current_user.rides.new(params[:ride])

    respond_to do |format|
      if @ride.save
        format.html { redirect_to [current_user,@ride], notice: 'Ride was successfully created.' }
        format.json { render json: @ride, 
                             status: :created, 
                             location: [current_user,@ride] }
      else
        format.html { render action: "new" }
        format.json { render json: @ride.errors, 
                             status: :unprocessable_entity }
      end
    end
  end

  private

  def load_rideable
    resource, id = request.path.split('/')[1, 2]
    @rideable = resource.singularize.classify.constantize.find(id)
  end
end
