class Event < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  mount_uploader :attachment, FileUploader
  belongs_to :event_category
  belongs_to :club_period
  has_many :event_responses
  belongs_to :faculty

  attr_accessor :event_locations
  scope :admin_pending_events, -> { where(event_status_id: EventStatus.admin_pending_status_ids).sort_by(&:last_event_response_date).reverse }
  scope :advisor_pending_events, -> { where(event_status_id: EventStatus.advisor_pending_status_ids).sort_by(&:last_event_response_date).reverse }
  scope :president_pending_events, -> { where(event_status_id: EventStatus.president_pending_status_ids).sort_by(&:last_event_response_date).reverse }
  scope :dean_pending_events, -> { where(event_status_id: EventStatus.dean_pending_status_id).sort_by(&:last_event_response_date).reverse }
  scope :approval_events, -> { where(event_status_id: EventStatus.approval_status_ids).sort_by(&:last_event_response_date).reverse }

  def last_event_response_date
    event_responses.order(created_at: :desc).first.created_at
  end

  def self.member_club_events(current_user)
    current_user.active_club_periods.compact.map { |clubperiod| Event.where(id: clubperiod.events.select { |event| event.id if event.event_responses.any? && event.event_responses.last.event_status_id == 2 }.compact) }.flatten
  end
end
