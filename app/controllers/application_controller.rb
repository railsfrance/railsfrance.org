class ApplicationController < ActionController::Base
  protect_from_forgery

  unless Rails.application.config.consider_all_requests_local
    rescue_from CanCan::AccessDenied, :with => :render_not_allowed
    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
    rescue_from ActionController::UnknownController, :with => :render_not_found
    rescue_from ActionController::UnknownAction, :with => :render_not_found
  end

  def render_not_found
    render '/errors/404.html.haml', :status => 404, :layout => 'application'
  end

  def render_not_allowed
    render '/errors/404.html.haml', :status => 403, :layout => 'application'
  end

  private

  def authenticate_admin_user! 
    render_not_allowed and return if user_signed_in? && (!current_user.role || current_user.role.empty?)
    authenticate_user! 
  end 

  def after_sign_in_path_for(resource)
    request.session[:pre_login_path] || super
  end
end
