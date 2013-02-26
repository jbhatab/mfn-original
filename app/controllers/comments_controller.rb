class CommentsController < ApplicationController
  before_filter :load_commentable


  def index
    @comments = @commentable.comments
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



end
