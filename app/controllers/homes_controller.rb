class HomesController < ApplicationController
  def index
    festival_year = FestivalYear.where("festival_year = ?", Time.now.year)
    @events = festival_year.events.find(:all, :conditions => ["start_at <= ? AND end_at >= ? ", Date.today, Date.today])
  end

  def about
  end

  def contact
  end
end
