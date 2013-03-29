class EventsController < ApplicationController

  respond_to :json, :html
  helper_method :sort_column, :sort_direction

  def index
    @events = Event.includes(:address,  :festival_year, :festival_year =>:festival)
                   .search(params[:search])
                   .where('addresses.country = ? AND festival_years.year = ? ', params[:country], params[:year])
                   .order('festivals.name ASC')
                   .paginate(:page => params[:page])
    
  end


  def new
    @event = Event.new
  end

  def map
    if params[:commit].eql?('Reset')
      redirect_to '/festival-map'
    end
    @events = Event.includes(:festival_year => :festival).search(params[:search])
    addresses = []
    @events.each do |event|
      unless event.address.longitude == 0
        addresses << event.address
      end
    end  
    @json = addresses.to_gmaps4rails do |address, marker|
      marker.infowindow render_to_string(:partial => "/events/infowindow", :locals => { :event => address.addressable})
      marker.title "#{address.addressable.festival_year.festival.name}"
      if address.addressable.start_at == nil
        marker.json({ :id => address.addressable.id, :event_type => address.addressable.event_type})
      else
        marker.json({ :start_at =>address.addressable.start_at.month, :id => address.addressable.id, :event_type => address.addressable.event_type})
      end
    end
    
    respond_with @json
    @events = Event.all
  end


  def rideshare
    if params[:commit].eql?('Reset')
      redirect_to '/rideshare'
    end
    @events = Event.includes(:festival_year => :festival).search(params[:search])
    addresses = []
    list = []
    @events.each do |event|
      unless event.address.longitude == 0
        addresses << event.address
        list << event
      end
    end  
    @json = addresses.to_gmaps4rails do |address, marker|
      marker.infowindow render_to_string(:partial => "/events/infowindow", :locals => { :event => address.addressable})
      marker.picture({
                'picture' => view_context.image_path("red-dot.png"),
                'width'   => 20,
                'height'  => 20
               })
      marker.title "#{address.addressable.festival_year.festival.name}"
      if address.addressable.start_at == nil
        marker.json({ :id => address.addressable.id, :event_type => address.addressable.event_type})
      else
        marker.json({ :start_at =>address.addressable.start_at.month, :id => address.addressable.id, :event_type => address.addressable.event_type})
      end
    end
    
    @list = list.paginate(:page => params[:page], :per_page => 13)
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


end
