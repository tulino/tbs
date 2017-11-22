class SystemAnnouncementPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    @user.present? && @user.admin? ? true : @record.is_view
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
