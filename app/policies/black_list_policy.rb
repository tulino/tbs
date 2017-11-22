class BlackListPolicy < ApplicationPolicy
  def index?
    @user.admin?
  end

  def show?
    @user.admin?
  end

  def edit?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def new?
    @user.admin? || @user.president?
  end

  def create?
    @user.admin? || (@user.president? && @record.user.member?(@user.president_or_advisor_club_period.club.id))
  end

  def destroy?
    @user.admin?
  end

  def change_approve_status?
    @user.admin?
  end
end
