class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?

   def after_sign_in_path_for(resource)
    user_path(current_user.id)
   end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  # def configure_permitted_parameters
    #strong parametersを設定し、usernameを許可
    # devise_parameter_sanitizer.permit(:sign_up)


  # end
end
