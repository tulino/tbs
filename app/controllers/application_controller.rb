class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  include ApplicationHelper

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password password_confirmation])
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
