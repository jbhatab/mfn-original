class AuthenticationsController < ApplicationController

  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    if current_user
      authentication = current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
      redirect_to edit_user_registration_path, :notice => 'Added authentication method'
      return
    end
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in successfully."
      @user = authentication.user
      sign_in_and_redirect(:user, @user)
    else
      @user = User.find_first_by_auth_conditions(omniauth)
      if !@user.new_record?
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, @user)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
