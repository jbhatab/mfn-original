class TopicsController < ApplicationController

  before_filter :authenticate_user!, except: :show
  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
    @post = @topic.posts.first
    unless @topic.user_id == current_user.id and @post.user_id == current_user.id or current_user.admin == true
      return redirect_to forum_path(@topic.forum_id), notice: 'You cannot update someone elses topic.'
    end

  end

  # POST /topics
  # POST /topics.json
  def create

    @topic = Topic.new(:name => params[:topic][:name], :last_poster_id => current_user.id, :last_post_at => Time.now, :forum_id => params[:topic][:forum_id], :user_id => current_user.id)

    if @topic.save
      @post = Post.new(:content => params[:post][:content], :topic_id => @topic.id, :user_id => current_user.id)

      if @post.save
        flash[:notice] = "Successfully created topic."
        redirect_to "/forums/#{@topic.forum_id}"
      else
        redirect :action => 'new'
      end
    else
      render :action => 'new'
    end
  end
  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])
    unless @topic.user_id == current_user.id or current_user.admin == true
      return redirect_to forum_path(@topic.forum_id), notice: 'You cannot update someone elses topic.'
    end

    if @topic.update_attributes(params[:topic])
      @post = @topic.posts.first
      if @post.update_attributes(:content => params[:post][:content])
        redirect_to "/topics/#{@topic.id}", notice: 'Topic was successfully updated.' 
      else
        render action: "edit" 
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
    unless @topic.user_id == current_user.id or current_user.admin == true
      return redirect_to forum_path(@topic.forum_id), notice: 'You cannot destroy someone elses topic.'
    end
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to "/forums/#{@topic.forum_id}"   }
      format.json { head :no_content }
    end
  end
end
