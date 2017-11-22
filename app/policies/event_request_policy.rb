class EventRequestPolicy < ApplicationPolicy
  def index?
    @user.admin? || @user.advisor? || @user.president?
  end

  def show?
    @user.admin? || @user.advisor? || @user.president?
  end

  def edit?
    @user.admin? || @user.advisor? || @user.president?
  end

  def update?
    @user.admin? || @user.advisor? || @user.president?
  end

  def create?
    @user.admin? || @user.advisor? || @user.president?
  end

  def destroy?
    @user.admin? || @user.advisor? || @user.president?
  end
end
