class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :require_logged_in_user

  def require_logged_in_user
    redirect_to login_path unless current_user.present?
  end
end
