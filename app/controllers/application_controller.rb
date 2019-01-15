class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  include RequestsHelper

  private

  def is_admin?
    return if current_user.admin?
    redirect_to root_path
    flash[:danger] = t ".permission"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
