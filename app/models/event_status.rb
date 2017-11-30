class EventStatus < ActiveRecord::Base
  require 'set'
  has_many :event_responses
  scope :admin_pending_status_ids, -> { where(status: ['SKS Admin Onayı Bekleniyor', 'Akademik Danışman Onayı Bekleniyor', 'Dekan Onayı Bekleniyor']).pluck(:id) }
  scope :all_manager_status_ids, -> { where(status: ['SKS Admin Onayı Bekleniyor', 'SKS Admin Onayladı', 'SKS Admin Onaylamadı', 'Akademik Danışman Onayladı', 'Akademik Danışman Onaylamadı']).pluck(:id) }
  scope :advisor_pending_status_ids, -> { where(status: ['Akademik Danışman Onayı Bekleniyor']).pluck(:id) }
  scope :president_pending_status_ids, -> { where.not(status: ['SKS Admin Onayladı', 'Süresi Geçmiş']).pluck(:id) }
  scope :approval_status_ids, -> { where(status: ['SKS Admin Onayladı']).pluck(:id) }
  scope :advisor_approved_status_id, -> { find_by(status: 'Akademik Danışman Onayladı').id }
  scope :dean_approved_status_id, -> { find_by(status: 'Dekan Onayladı').id }
  scope :admin_pending_status_id, -> { find_by(status: 'SKS Admin Onayı Bekleniyor').id }
  scope :dean_pending_status_id, -> { find_by(status: ['Dekan Onayı Bekleniyor']).id }
  scope :past_event_status_id, -> { find_by(status: ['Süresi Geçmiş']).id }

  LABELS = {
    'success' => %w[
      SKS\ Admin\ Onayladı
      Akademik\ Danışman\ Onayladı
      Dekan\ Onayladı
    ].to_set,

    'warning' => %w[
      Akademik\ Danışman\ Onayı\ Bekleniyor
    ].to_set,

    'info' => %w[
      Dekan\ Onayı\ Bekleniyor
    ].to_set,

    'danger' => %w[
      SKS\ Admin\ Onayı\ Bekleniyor
    ].to_set,

    'default' => %w[
      SKS\ Admin\ Onaylamadı
      Süresi\ Geçmiş
    ].to_set,

    'primary' => %w[
      Akademik\ Danışman\ Onaylamadı
      Dekan\ Onaylamadı
    ].to_set
  }.freeze

  def label_type
    LABELS.select { |_, v| v.include? status }.keys.first || 'default'
  end
end
