# encoding: utf-8

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
    @user.admin? || (@user.president_or_advisor_club_period == @record.club.active_club_period)
  end

  def destroy?
    @user.admin?
  end

  def change_approve_status?
    @user.admin?
  end
end
