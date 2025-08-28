# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  protect_from_forgery with: :exception, prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :force_current_user


  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :full_name, :role ])
  end

  def force_current_user
    return unless user_signed_in?
    @forced_current_user_id ||=current_user.id
  end
end
