# encoding: utf-8

class AnnouncementPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    @user.present? && (@user.admin? || @user.president?(@record.club_period.id) || @user.advisor?(@record.club_period.id)) ? true : @record.is_view
  end

  def edit?
    @user.admin? || @user.advisor?(@record.club_period.id) || @user.president?(@record.club_period.id)
  end

  def update?
    @user.admin? || @user.advisor?(@record.club_period.id) || @user.president?(@record.club_period.id)
  end

  def new?
    @user.admin? || @user.present?
  end

  def create?
    @user.admin? || @user.advisor?(@record.club_period.id) || @user.president?(@record.club_period.id)
  end

  def destroy?
    @user.admin? || @user.advisor?(@record.club_period.id) || @user.president?(@record.club_period.id)
  end
end
