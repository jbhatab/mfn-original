class RidesController < ApplicationController
  respond_to :json, :html
  before_filter :load_rideable, :except => :rides_gmap
  before_filter :authenticate_user!, :except => [:index, :rides_gmap]

  
  def index
    @rides = @rideable.rides
  end

  def rides_gmap
    @rides = Ride.includes(:event => {:festival_year => :festival}).search(params[:search])
    addresses = []
    @rides.each do |ride|
      if ride.address.gmaps
        addresses << ride.address
      end
    end  
    @json = addresses.to_gmaps4rails do |address, marker|
      marker.infowindow render_to_string(:partial => "/rides/infowindow", :locals => { :ride => address.addressable})
      if address.addressable.giving_ride
        marker.picture({
                'picture' => view_context.image_path("orange-dot.png"),
                'width'   => 20,
                'height'  => 20
               })
      else
        marker.picture({
                'picture' => view_context.image_path("yellow-dot.png"),
                'width'   => 20,
                'height'  => 20
               })
      end
      marker.title "#{address.addressable.user.username}"
      if address.addressable.event.start_at == nil
        marker.json({:ride_id => address.addressable.id, :event_id => address.addressable.event.id, :ride_event_type => address.addressable.event.event_type })
      else
        marker.json({:ride_id => address.addressable.id, :event_id => address.addressable.event.id, :ride_event_type => address.addressable.event.event_type, :ride_event_date => address.addressable.event.start_at.month })
      end
    end
    
    respond_with @json
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
        format.html { redirect_to '/my-rides', notice: 'Ride was successfully created.' }
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

  def destroy
    @ride = Ride.find(params[:id])
    @ride.destroy

    respond_to do |format|
      format.html { redirect_to '/my-rides' }
      format.json { head :no_content }
    end
  end

  private

  def load_rideable
    resource, id = request.path.split('/')[1, 2]
    @rideable = resource.singularize.classify.constantize.find(id)
  end
end
