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

  def new?
    @user.present? && @user.admin_or_president?
  end

  def create?
    @user.present? && @user.admin_or_president?
  end

  def destroy?
    @user.present? && (@user.admin? || (@user.president?(@record.club_period.id) && @record.club_period.club.club_setting.is_active && has_admin_status_id?(@record.event_responses.map(&:event_status_id))))
  end

  def download_events
    @user.admin?
  end

  private

  def has_admin_status_id?(status_ids)
    (EventStatus.all_manager_status_ids & status_ids).empty?
  end
end
