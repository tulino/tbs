class HomePolicy < ApplicationPolicy
  def index?
    true
  end

  def dashboard_admin?
    @user.admin?
  end

  def dashboard_advisor?
    @user.advisor?
  end

  def dashboard_club?
    @user.president?
  end
end
