class HomesController < ApplicationController
  def index
    @festivals = Festival.find(:all, :conditions => ["start_date <= ? AND end_date >= ? ", Date.today, Date.today])
  end

  def about
  end

  def contact
  end
end
