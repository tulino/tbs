class FacultyPolicy < ApplicationPolicy
  def index?
    @user.admin? || @user.advisor?
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
