class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected
  def after_sign_in_path_for(resource)
  if resource.seller?
    seller_dashboard_path
  else
    buyers_path
  end
end
def after_sign_out_path_for(resource_or_scope)
  new_user_session_path # redirects to login page after logout
end



  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end
end
