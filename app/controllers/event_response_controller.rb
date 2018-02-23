class EventResponseController < ApplicationController
  def create
    @event_response = EventResponse.new(event_response_params)
    @event = Event.find(event_response_params['event_id'])
    if @event_response.save
      event_status_id = event_response_params['event_status_id'].to_i
      @event.current_user = current_user
      @event.update(event_status_id: event_status_id)
      check_event_status(@event, event_status_id)
      flash.now[:error] = 'Başarılı'
    else
      flash.now[:error] = 'Başarısız'
    end
    redirect_to :back
  end

  def destroy; end

  private

  def check_event_status(event, event_status_id)
    advisor_ok = event_status_id == EventStatus.advisor_approved_status_id
    dean_ok = event_status_id == EventStatus.dean_approved_status_id
    return unless advisor_ok || dean_ok
    if event.club_period.club.club_category.vocational_club? && advisor_ok
      create_response_and_send_mail(event, EventStatus.dean_pending_status_id)
    else
      create_response_and_send_mail(event, EventStatus.admin_pending_status_id)
    end
  end

  def create_response_and_send_mail(event, event_status)
    EventResponse.create(event_id: event.id, event_status_id: event_status)
    Event.find(event.id).update(event_status_id: event_status)
    return unless event.try(:faculty).try(:role).present?
    if event_status == EventStatus.admin_pending_status_id
      EventMailer.approval_admin_event(event).deliver_now
    else
      EventMailer.approval_to_event(event.faculty.role.user, event).deliver_now
    end
  end

  def event_response_params
    params.fetch(:event_response, {}).permit(:event_id, :event_status_id, :explanation)
  end
end
