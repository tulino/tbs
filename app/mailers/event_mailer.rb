# encoding: utf-8

class EventMailer < ActionMailer::Base
  default from: ENV['MAIL_ADDRESS']
  default template_path: 'mail/event'
  helper :application
  include ApplicationHelper
  layout 'sks_mail'

  def approval_to_event(user, event)
    return unless user.try(:profile).try(:email).present?
    @user = user
    @event = event
    mail(to: @user.profile.email, subject: "Onay Bekleyen Etkinlik")
  end

  def approval_admin_event(event)
    @event = event
    admin_users.each do |email|
      mail(to: email, subject: "Onay Bekleyen Etkinlik")
    end
  end
end
