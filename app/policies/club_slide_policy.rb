class ClubSlidePolicy < ApplicationPolicy
  def index?
    @user.advisor?
  end

  def show?
    @user.advisor?
  end

  def edit?
    @user.advisor?
  end

  def update?
    @user.advisor?
  end

  def create?
    @user.advisor?
  end

  def destroy?
    @user.advisor?
  end
end
