class SessionsController < ApplicationController
  def new
  end

  def omni 
    render :text => request.env['rack.auth'].inspect
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to users_path, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to users_path, :notice => "Logged out!"
  end
end
