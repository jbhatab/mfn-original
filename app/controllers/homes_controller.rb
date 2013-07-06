class HomesController < ApplicationController

  def robots
    robots = File.read(Rails.root + "config/robots.#{Rails.env}.txt")
    render :text => robots, :layout => false, :content_type => "text/plain"
  end

  def index
    @events = Event.find(:all, :conditions => ["start_at <= ? AND end_at >= ? ", Date.today, Date.today])
    @blogs = Blog.paginate(:order=>"created_at DESC", :page => params[:page])
    @blog = Blog.first
  end


  def about
  end

  def contact
  end
end
