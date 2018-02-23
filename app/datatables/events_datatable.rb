class EventsDatatable < AjaxDatatablesRails::Base
  def_delegator :@view, :link_to
  def_delegator :@view, :event_status
  def_delegator :@view, :event_actions

  def view_columns
    @view_columns ||= {
      name: { source: "Event.title" },
      club: { source: "Club.name" },
      status: { source: "EventStatus.status", searchable: false, orderable: false },
      datetime: { source: "Event.datetime" },
      actions: { searchable: false, orderable: false }
    }
  end

  def data
    current_user = options[:current_user]
    records.map do |record|
      {
        name: link_to(record.title, record),
        club: link_to(record.club_period.club.try(:name), record.club_period.club),
        status: event_status(record),
        datetime: record.datetime.strftime("%d.%m.%Y - %H:%M"),
        actions: event_actions(record)
      }
    end
  end

  private

  def get_raw_records
    Event.includes({club_period: :club}, { event_responses: [:event_status] }).references(:club_period)
  end
end
