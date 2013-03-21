class CommentsController < ApplicationController
  before_filter :load_commentable
  before_filter :authenticate_user!, :find_comment, :only => [:upvote, :downvote]



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
    @comment = @commentable.comments.build(params[:comment])

    #@comment = @commentables.Comment.new
    if user_signed_in?
      @comment.user_id = current_user.id
    end
    @comment.save
    respond_to do |format|
      format.html { redirect_to(@commentable) }
    end
    
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html {redirect_to('/my-comments')}
      format.json { head :no_content }
      format.js
    end
  end

private

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def find_comment
    @comment = Comment.find(params[:id])
    if current_user.id == @comment.user_id
      flash[:notice] = "You can't vote on your own comment"
      redirect_to(@comment.commentable)
    end
  end


end
