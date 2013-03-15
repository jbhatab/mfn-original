class RidesController < ApplicationController
  respond_to :json, :html
  before_filter :load_rideable, :except => :rides_gmap
  before_filter :authenticate_user!, :except => [:index, :rides_gmap]

  
  def index
    @rides = @rideable.rides
  end

  def rides_gmap
    Ride.all.each do |ride|
      addresses << ride.address
    end  
    @json = addresses.to_gmaps4rails do |address, marker|
      marker.infowindow render_to_string(:partial => "/rides/infowindow", :locals => { :ride => address.ride})
      if address.ride.giving_ride
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
      marker.title "#{address.ride.user.username}"
      if address.ride.event.start_at == nil
        marker.json({:ride_id => address.ride.id, :ride_event_type => address.ride.event.event_type })
      else
        marker.json({:ride_id => address.ride.id, :ride_event_type => address.ride.event.event_type, :ride_event_date => address.ride.event.start_at.month })
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
