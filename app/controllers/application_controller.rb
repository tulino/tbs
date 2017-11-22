class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  include ApplicationHelper

  protected

  def configure_devise_permitted_parameters
    registration_params = %i[email password password_confirmation]
    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) do |u|
        u.permit(registration_params << :current_password, :image, :is_passive)
      end
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(registration_params)
      end
    end
  end

  def after_sign_in_path_for(_resource)
    URI.parse(request.referer).path if request.referer
  end

  def after_sign_out_path_for(_resource_or_scope)
    URI.parse(request.referer).path if request.referer
  end

  rescue_from Pundit::NotAuthorizedError, with: :permission_denied

  def permission_denied
    render(file: File.join(Rails.root, 'public/403.html'), status: 403, layout: false)
  end
end
