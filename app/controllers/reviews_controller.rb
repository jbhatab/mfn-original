class ReviewsController < ApplicationController
  before_filter :load_festival
  before_filter :authenticate_user!, :only => [:create, :upvote, :downvote]
  before_filter :find_review, :only => [:upvote, :downvote]


  def index
    @reviews = @festival.reviews
  end


  def upvote

    @review.upvote_from current_user
    redirect_to request.referrer
    
  end

  def downvote
    @review.downvote_from current_user
    redirect_to request.referrer
  end

  def create
    @review = @festival.reviews.build(params[:review])

    #@comment = @commentables.Comment.new
    @review.user_id = current_user.id
    @review.save
    respond_to do |format|
      format.html { redirect_to(@festival) }
    end
    
  end

  def destroy
    @review = @festival.reviews.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html {redirect_to(@festival)}
      format.json { head :no_content }
      format.js
    end
  end

  def update

    @review = @festival.reviews.find(params[:id])

     respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to @festival, notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      end
    end
  end

private

  def load_festival
    resource, id = request.path.split('/')[1, 2]
    @festival = resource.singularize.classify.constantize.find(id)
  end

  def find_review
    @review = Review.find(params[:id])
    if current_user.id == @review.user_id
      flash[:notice] = "You can't vote on your own comment"
      redirect_to request.referrer
    end
  end

end
