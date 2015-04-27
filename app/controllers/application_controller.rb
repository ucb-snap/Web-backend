class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:sign_in) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
  end


  def find_users(input)
    # Input: Parameters Hash (params)
    # Output: If all additional owners are valid, then a list of those users
    #         If the additional owners are invalid, then returns False

    additional_users = input[:additional_owners].split(/ |, |,/)
    additional_users = additional_users.select{ |email| email != current_user.email}
    valid = User.validate_emails(additional_users)
    unless valid[0]
      flash[:alert] = "No User(s) with the following emails are registered: " + valid[1]
      return false
    else
      valid[1]
    end
  end
end
