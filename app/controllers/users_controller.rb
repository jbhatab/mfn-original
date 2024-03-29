class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  before_filter :authenticate_user!, except: :show
  before_filter :check_email, :only => :add_to_contests

  def check_email
    if current_user.email == ""
      redirect_to '/contests', notice: 'You have to enter your email on your account in "Edit Profile"'
    end
  end
  
  def new_message
    @message = current_user.messages.build
  end

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def add_to_contests
    
    current_user.contests << Contest.find(params[:id])
    redirect_to '/contests', notice: 'You have successfully been entered.'
  end

  def remove_from_contests
    contest    = Contest.find(params[:id])
    contest = ContestsUser.find_by_user_id_and_contest_id(current_user.id, contest.id)

    contest.delete

    redirect_to '/contests', notice: 'You have left the contest.'
  end

  def add_to_festival_lineup
    current_user.events << Event.find(params[:id])
    redirect_to '/festival-lineup'
  end

  def remove_from_festival_lineup
    @event = current_user.events.find(params[:id])
    current_user.events.delete(@event.id)
    redirect_to '/festival-lineup'
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user  }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
