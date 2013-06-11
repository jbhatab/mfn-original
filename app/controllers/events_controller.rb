class EventsController < ApplicationController

  respond_to :json, :html
  helper_method :sort_column, :sort_direction
  caches_action :get_map_events
  caches_action :get_events_rideshare

  def index
    @search = Event.search(params[:search])
                   
            
                   
    @events = @search.includes(:address,  :festival_year, :festival_year =>:festival)
                     .where('addresses.country = ? AND festival_years.year = ? ', params[:country], params[:year])
                     .order('festivals.name ASC')
                     .paginate(:page => params[:page])
    
  end


  def new
    @event = Event.new
  end

  def map
    #expire_action :action => :get_map_events
    @search = Address.search(params[:search])
    

  end

  def get_map_events

    @search = Address.search(params[:search])
    addresses = @search.where("longitude != ? and addressable_type = ?", 0, "Event")
    @json = addresses.to_gmaps4rails do |address, marker|
      marker.infowindow render_to_string(:partial => "/events/infowindow", :locals => { :event => address.addressable})
      if address.addressable.start_at == nil
        marker.json({ :id => address.addressable.id, :event_type => address.addressable.event_type})
      else
        marker.json({ :start_at =>address.addressable.start_at.month, :id => address.addressable.id, :event_type => address.addressable.event_type})
      end
    end
    
    respond_with @json

    
  end

  def get_events_rideshare
    events = Event.includes(:address, :festival_year => :festival).where('addresses.longitude != ?', 0)
    #addresses = Address.where("longitude != ? and addressable_type = ?", 0, "Event").includes(:addressable => {:festival_year => :festival})
    @json = events.to_gmaps4rails do |event, marker|
      marker.infowindow render_to_string(:partial => "/events/infowindow", :locals => { :event => event})
      marker.picture({
                'picture' => view_context.image_path("red-dot.png"),
                'width'   => 20,
                'height'  => 20
               })
      marker.title "#{event.festival_year.festival.name}"
      if event.start_at == nil
        marker.json({ :id => event.id, :event_type => event.event_type})
      else
        marker.json({ :start_at => event.start_at.month, :id => event.id, :event_type => event.event_type})
      end
    end
    respond_with @json
  end

  def rideshare
    #expire_action :action => :get_events_rideshare
    @search = Event.search(params[:search])
    @events = @search.joins(:address)
                     .where("addresses.longitude != ?", 0)
                     .paginate(:page => params[:page], :per_page => 13)
    

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


end
