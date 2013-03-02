class CommentsController < ApplicationController
  before_filter :load_commentable
  before_filter :find_comment, :only => [:upvote, :downvote]



  def index
    @comments = @commentable.comments
  end

  def upvote
    @comment.upvote_from current_user
    redirect_to(@comment.commentable)
    
  end

  def downvote
    @comment.downvote_from current_user
    redirect_to(@comment.commentable)
  end

  def create
    @comment = @commentable.comments.new(params[:comment])

    #@comment = @commentables.Comment.new
    if user_signed_in?
      @comment.user_id = current_user.id
    end
    @comment.save
    redirect_to(@commentable)
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy
    redirect_to(@commentable)
  end

private

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def find_comment
    @comment = Comment.find(@commentable.id)
    unless user_signed_in?
      redirect_to(@comment.commentable) 
      flash[:notice] = "You have to log in to vote"
    end
    if current_user.id == @comment.user_id
      flash[:notice] = "You can't vote on your own comment"
      redirect_to(@comment.commentable)
    end
  end


end
