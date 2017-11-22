class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard_admin, :dashboard_advisor, :dashboard_club]
  def index
    @events = Event.order('created_at DESC').last(3)
    @system_announcements = Event.order('created_at DESC').last(3)
  end

  def dashboard_admin; end

  def dashboard_advisor; end

  def dashboard_president; end
end
