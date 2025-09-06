# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  protect_from_forgery with: :exception, prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?


  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :full_name, :role ])
  end

  def is_user_admin?
      redirect_to root_path, notice: "You must be an admin to access the requested page" if !(current_user.admin?)
  end

  def is_user_admin_or_teacher?
    redirect_to root_path, notice: "You must be an admin or teacher to access the requested page" unless current_user.admin? || current_user.teacher?
  end
end
