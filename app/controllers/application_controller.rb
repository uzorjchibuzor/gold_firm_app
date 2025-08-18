class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :force_current_user


  private

  def force_current_user
    return unless user_signed_in?
    @forced_current_user_id ||=current_user.id
  end
end
