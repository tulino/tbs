class EventLocationPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def edit?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def create?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end
end
