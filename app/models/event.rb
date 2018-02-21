class Event < ActiveRecord::Base
  belongs_to :event_category
  belongs_to :club_period
  has_many :event_responses
  belongs_to :faculty
  # validations
  validates :image, file_size: { maximum: 10.megabytes.to_i }
  validate :datetime_limit

  # uploaders
  mount_uploader :image, PhotoUploader
  mount_uploader :attachment, FileUploader

  attr_accessor :event_locations
  attr_accessor :current_user
  scope :admin_pending_events, -> { where(event_status_id: EventStatus.admin_pending_status_ids).sort_by(&:last_event_response_date).reverse }
  scope :advisor_pending_events, -> { where(event_status_id: EventStatus.advisor_pending_status_ids).sort_by(&:last_event_response_date).reverse }
  scope :president_pending_events, -> { where(event_status_id: EventStatus.president_pending_status_ids).sort_by(&:last_event_response_date).reverse }
  scope :dean_pending_events, -> { where(event_status_id: EventStatus.dean_pending_status_id).sort_by(&:last_event_response_date).reverse }
  scope :approval_events, -> { where(event_status_id: EventStatus.approval_status_ids).sort_by(&:last_event_response_date).reverse }
  scope :past_events, -> { where(event_status_id: EventStatus.past_event_status_id).sort_by(&:last_event_response_date).reverse }

  def president
    User.find(president_id)
  end

  def advisor
    User.find(advisor_id)
  end

  def last_event_response_date
    event_responses.order(created_at: :desc).first.created_at
  end

  def self.member_club_events(current_user)
    current_user.active_club_periods.compact.map { |clubperiod| Event.where(id: clubperiod.events.select { |event| event.id if event.event_responses.any? && event.event_responses.last.event_status_id == 2 }.compact) }.flatten
  end

  def datetime_limit
    return if current_user.admin? || current_user.advisor?
    return if persisted? && datetime == datetime_was
    errors.add(:datetime, '15 gün sonrası için etkinlik oluşturabilirsiniz!') if datetime < Date.today.next_day(15)
  end
end
