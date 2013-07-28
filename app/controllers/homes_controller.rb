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

  def admin
    @comments = Comment.order("created_at").limit(10)
    @reviews = Review.order("created_at").limit(10)
    @rides = Ride.order("created_at").limit(10)
    @posts = Post.order("created_at").limit(10)

  end

  def contact
  end
end
