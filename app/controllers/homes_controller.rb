class HomesController < ApplicationController
  def index
    @events = Event.find(:all, :conditions => ["start_at <= ? AND end_at >= ? ", Date.today, Date.today])
  end

  def about
  end

  def contact
  end
end
