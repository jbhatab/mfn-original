class CustomFailure < Devise::FailureApp
  def redirect_url
    if warden_options[:scope] == [:user, :ride, :blog, :review, :comment]
      new_user_registration_path
    else
      new_user_registration_path
    end
  end
  def respond
    if http_auth?
      http_auth
    elsif Rails.env.production?
      redirect_to 'http://www.musicfestivalnation.com/users/login'
    else
      redirect_to '/users/login'
    end
  end
end