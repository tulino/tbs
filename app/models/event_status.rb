class EventStatus < ActiveRecord::Base
  has_many :event_responses
  scope :admin_pending_status_ids, -> { where(status: ["SKS Admin Onayı Bekleniyor", "Akademik Danışman Onayı Bekleniyor", "Dekan Onayı Bekliyor"]).pluck(:id) }
  scope :advisor_pending_status_ids, -> { where(status: ["Akademik Danışman Onayı Bekleniyor"]).pluck(:id) }
  scope :president_pending_status_ids, -> { where.not(status: ["SKS Admin Onayladı"]).pluck(:id) }
  scope :dean_pending_status_ids, -> { where(status: ["Dekan Onayı Bekliyor"]).pluck(:id) }
  scope :approval_status_ids, -> { where(status: ["SKS Admin Onayladı"]).pluck(:id) }
  scope :advisor_approved_status_id, -> { find_by(status: "Akademik Danışman Onayladı").id }
end
