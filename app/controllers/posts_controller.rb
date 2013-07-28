class PostsController < ApplicationController

  before_filter :authenticate_user!


  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit

    @post = Post.find(params[:id])
    unless @post.user_id == current_user.id or current_user.admin == true
      return redirect_to @post.topic, notice: 'You cannot update someone elses post.'
    end
  end

  # POST /posts
  # POST /posts.json
  def create  
    @post = Post.new(:content => params[:post][:content], :topic_id => params[:post][:topic_id], :user_id => current_user.id)  
    if @post.save  
      @topic = Topic.find(@post.topic_id)  
      @topic.update_attributes(:last_poster_id => current_user.id, :last_post_at => Time.now)  
      flash[:notice] = "Successfully created post."  
      redirect_to "/topics/#{@post.topic_id}"  
    else  
      render :action => 'new'  
    end  
  end  


  # PUT /posts/1
  # PUT /posts/1.json
  def update  
    @post = Post.find(params[:id])  

    unless @post.user_id == current_user.id or current_user.admin == true
      return redirect_to @post.topic, notice: 'You cannot update someone elses post.'
    end
    if @post.update_attributes(params[:post])  
      @topic = Topic.find(@post.topic_id)  
      @topic.update_attributes(:last_poster_id => current_user.id, :last_post_at => Time.now)  
      flash[:notice] = "Successfully updated post."  
      redirect_to topic_path(@post.topic_id)  
    else  
      render :action => 'edit'  
    end  
  end  

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    unless @post.user_id == current_user.id or current_user.admin == true
      return redirect_to @post.topic, notice: 'You cannot destroy someone elses post.'
    end
    @post.destroy

    respond_to do |format|
      format.html { redirect_to topic_path(@post.topic_id) }
      format.json { head :no_content }
    end
  end
end
