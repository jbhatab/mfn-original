class FestivalsController < ApplicationController
  # GET /festivals
  # GET /festivals.json
  respond_to :json, :html
  helper_method :sort_column, :sort_direction
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD'],
                               only: [:new, :edit, :destroy]
  def import
    Festival.import(params[:file])
    redirect_to root_url, notice: "festivals imported"
  end
  
  def filter
    flash[:notice] = "Filtered Mother Fucker"
  end

  def index
    @festivals = Festival.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @festivals }
    end
  end

  def sort_column
    Festival.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end


  def map
    @festivals = Festival.find(:all, :conditions => 'longitude!=0')
    @json = @festivals.to_gmaps4rails do |festival, marker|
      marker.infowindow render_to_string(:partial => "/festivals/infowindow", :locals => { :festival => festival})
      marker.title "#{festival.name}"
      marker.json({ :id => festival.id, :festivaltype => festival.festivaltype})
    end
    respond_with @json
  end

  def rideshare
    @ride = Ride.new
    @festivals = Festival.find(:all, :conditions => 'longitude!=0')
    @json = @festivals.to_gmaps4rails do |festival, marker|
      marker.infowindow render_to_string(:partial => "/festivals/infowindow", :locals => { :festival => festival})
      marker.picture({
                'picture' => view_context.image_path("red-dot.png"),
                'width'   => 20,
                'height'  => 20
               })
      marker.title "#{festival.name}"
      if festival.start_date == nil
        marker.json({ :id => festival.id, :festivaltype => festival.festivaltype})
      else
        marker.json({ :start_date =>festival.start_date.month, :id => festival.id, :festivaltype => festival.festivaltype})
      end
    end
    @list = Festival.paginate(:page => params[:page]).find(:all, :conditions => 'longitude!=0')


    respond_with @json
  end
  # GET /festivals/1
  # GET /festivals/1.json
  def show
    @festival = Festival.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @festival }
    end
  end

  # GET /festivals/new
  # GET /festivals/new.json
  def new
    @festival = Festival.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @festival }
    end
  end

  # GET /festivals/1/edit
  def edit
    @festival = Festival.find(params[:id])
  end

  # POST /festivals
  # POST /festivals.json
  def create
    @festival = Festival.new(params[:festival])

    respond_to do |format|
      if @festival.save
        FestivalMailer.submit_festival(@festival).deliver
        format.html { redirect_to @festival, notice: 'Festival was successfully created.' }
        format.json { render json: @festival, status: :created, location: @festival }
      else
        format.html { render action: "new" }
        format.json { render json: @festival.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /festivals/1
  # PUT /festivals/1.json
  def update
    @festival = Festival.find(params[:id])

    respond_to do |format|
      if @festival.update_attributes(params[:festival])
        format.html { redirect_to @festival, notice: 'Festival was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @festival.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /festivals/1
  # DELETE /festivals/1.json
  def destroy
    @festival = Festival.find(params[:id])
    @festival.destroy

    respond_to do |format|
      format.html { redirect_to festivals_url }
      format.json { head :no_content }
    end
  end

  private

  def submit_festival_email
    FestivalMailer.submit_festival(self).deliver
  end
end
