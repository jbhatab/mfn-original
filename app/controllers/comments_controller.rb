class CommentsController < ApplicationController
  before_filter :get_festival

  def get_festival
    @festtival = Festival.find(params[:id])
  end

  def index
    @comments = @festival.comments.all
  end

  def create
    @comment = @festival.Comment.new
    if current_user
      @comment.user = current_user.id
    else
      @comment.user = 'guy'
    end
  end
end
