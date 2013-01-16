class CommentsController < ApplicationController
  before_filter :find_user
  
  def find_user
    @user = current_user
  end

  def index
    @comments = @user.comments
    @comment = @user.comments.build(params[:comment])
  end

  def create
    @comment = @user.comments.build(params[:comment])
    if current_user
      @comment.user = current_user
    else 
      @comment.user = 'guest'
    end
  end

  def destroy
  end
end
