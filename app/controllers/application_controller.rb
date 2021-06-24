class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?

  # before_action :authenticate_user!

  # def authenticate_user!
  #     unless user_signed_in?
  #       redirect_to new_user_session_path
  #     end
  # end

   def after_sign_in_path_for(resource)
    user_path(current_user.id)
   end
# ログアウト時のフラッシュ表示
   def after_sign_out_path_for(resource)
       flash[:notice] = "Signed out successfully."
       root_path
   end

  protected
# 名前ログイン併せてconfig/initializers/devise.rbを確認
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:name])

    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])

  end

  # def configure_permitted_parameters
    #strong parametersを設定し、usernameを許可
    # devise_parameter_sanitizer.permit(:sign_up)


  # end
end
