class EventsController < ApplicationController

  respond_to :json, :html
  before_filter :get_festival_year

  def index
    @events = @festival.events
  end

  def edit
  end

  def new
    @event = Event.new
  end

  def map
    @events = Event.all
    @events.each do |event|
      unless event.address.longitude == 0
        addresses << event.address
      end
    end  
    @json = addresses.to_gmaps4rails do |address, marker|
      marker.infowindow render_to_string(:partial => "/festivals/infowindow", :locals => { :festival => festival})
      marker.title "#{address.event.festival_year.festival.name}"
      marker.json({ :id => address.event.id, :event_type => address.event.event_type})
    end
    respond_with @json
  end


  def rideshare
    @ride = Ride.new
    @events = Event.all
    @events.each do |event|
      unless event.address.longitude == 0
        addresses << event.address
        list << event
      end
    end  
    @json = addresses.to_gmaps4rails do |address, marker|
      marker.infowindow render_to_string(:partial => "/events/infowindow", :locals => { :event => address.event})
      marker.picture({
                'picture' => view_context.image_path("red-dot.png"),
                'width'   => 20,
                'height'  => 20
               })
      marker.title "#{event.festival_year.festival.name}"
      if address.event.start_at == nil
        marker.json({ :id => address.event.id, :festivaltype => address.event.event_type})
      else
        marker.json({ :start_at =>address.event.start_at, :id => address.event.id, :event_type => address.event.event_type})
      end
    end
    @list = list.paginate(:page => params[:page])
    respond_with @json
  end

  def create
    @event = @festival.events.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @festival, notice: 'Event was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def show
    @event = @festival_year.events.find(params[:id])
  end

  def get_festival_year
    @festival_year = FestivalYear.find(params[:festival_year_id])
  end
end
