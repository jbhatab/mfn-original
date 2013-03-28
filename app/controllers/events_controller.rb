class EventsController < ApplicationController

  respond_to :json, :html
  helper_method :sort_column, :sort_direction

  def index
    if params[:sort] == "name" 
      @events = sort_by_name
    elsif params[:sort] == "state" or params[:sort] == "region"
      @events = sort_by_location
    else
      @events = sort
    end
    
  end

  def sort
    Event.search(params[:search]).joins(:address,  :festival_year).where('addresses.country = ? AND festival_years.year = ? ', params[:country], params[:year]).order(sort_column + " " + sort_direction).paginate(:page => params[:page])
  end

  def sort_by_name
    Event.search(params[:search]).joins(:address,  :festival_year).where('addresses.country = ? AND festival_years.year = ? ', params[:country], params[:year]).paginate(:page => params[:page],
                                                                                                                                                                                         :include => {:festival_year =>:festival},
                                                                                                                                                                                         :order => "festivals.#{params[:sort]} " + sort_direction)
  end

  def sort_by_location
    Event.search(params[:search]).joins(:address,  :festival_year).where('addresses.country = ? AND festival_years.year = ? ', params[:country], params[:year]).paginate(:page => params[:page],
                                                                                                                                                                                         :include => :address,
                                                                                                                                                                                         :order => "addresses.#{params[:sort]} #{sort_direction}")
  end

  def sort_column
    Event.column_names.include?(params[:sort]) ? params[:sort] : "start_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  def edit
  end

  def new
    @event = Event.new
  end

  def map
    @events = Event.all
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
    @events = Event.search(params[:search]).includes(:festival_year => :festival)
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
