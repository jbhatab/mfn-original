 class FestivalsController < ApplicationController
  # GET /festivals
  # GET /festivals.json
  respond_to :json, :html
  helper_method :sort_column, :sort_direction
  before_filter :check_admin, :only => [:create, :new, :edit, :destroy]
  
  def check_admin
    if user_signed_in?
      if current_user.admin == false
        redirect_to '/'
      end
    else
      redirect_to '/'
    end
  end

  def import
    Festival.import(params[:file])
    redirect_to root_url, notice: "festivals imported"
  end
  

  def index
    @festivals = Festival.search(params[:search]).includes(:festival_years => {:events => :address}).where('addresses.country = ? AND festival_years.year = ? ', params[:country], params[:year]).order(sort_column + " " + sort_direction).paginate(:page => params[:page])
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

  
  # GET /festivals/1
  # GET /festivals/1.json
  def show
    @festival = Festival.find(params[:id])
    if user_signed_in? 
      if @festival.reviews.where("user_id = ?", current_user.id) != []
        @user_review = @festival.reviews.where("user_id = ?", current_user.id).first
      else
        @user_review = nil
      end
    else
      @user_review = nil
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @festival }
    end
  end

  # GET /festivals/new
  # GET /festivals/new.json
  def new
    @festival = Festival.new
    
    fy = @festival.festival_years.build
    e = fy.events.build
    a = e.build_address
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @festival }
    end
  end

  def submit_festival
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
        format.html { redirect_to '/admin', notice: 'Festival was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
      
  end

  def submit_a_new_festival
    @festival = Festival.new(params[:festival])
    FestivalMailer.submit_festival(@festival).deliver
    redirect_to '/festival-list/US/2013', notice: 'Festival was successfully submitted.'
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
