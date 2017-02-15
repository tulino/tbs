# encoding: utf-8

class EventPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    if @user.present? && (@user.admin? || @user.president?(@record.club_period.id) || @user.advisor?(@record.club_period.id))
      true
    elsif @record.event_responses.last.event_status.id == 2
      true
    else
      false
    end
  end

  def edit?
    @user.present? && (@user.admin? || (@user.president?(@record.club_period.id) && @record.club_period.club.club_setting.is_active && (@record.event_responses.last.event_status.id != 2) && (@record.event_responses.last.event_status.id != 5)))
  end

  def update?
    @user.present? && (@user.admin? || (@user.president?(@record.club_period.id) && @record.club_period.club.club_setting.is_active && (@record.event_responses.last.event_status.id != 2) && (@record.event_responses.last.event_status.id != 5)))
  end

  def create?
    club_period = @user.president_or_advisor_club_period
    @user.present? && (@user.admin? || (club_period.present? && @user.president?(club_period) && club_period.club.club_setting.is_active))
  end

  def destroy?
    @user.present? && (@user.admin? || (@user.president?(@record.club_period.id) && @record.club_period.club.club_setting.is_active))
  end

  def download_events
    @user.admin?
  end
end
