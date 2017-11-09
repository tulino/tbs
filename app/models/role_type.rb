class RoleType < ActiveRecord::Base
  has_many :roles

  # scopes
  scope :member_id, -> { find_by(name: 'Üye').id }
  scope :club_member_type_ids, -> { where(name: %w(Başkan Üye)).pluck(:id) }
  scope :president_id, -> { find_by(name: 'Başkan').id }
  scope :dean_id, -> { find_by(name: 'Dekan').id }
  scope :advisor_id, -> { find_by(name: 'Akademik Danışman').id }
  scope :vise_advisor_id, -> { find_by(name: 'Akademik Danışman Yardımcısı').id }
  scope :admin_id, -> { find_by(name: 'Admin').id }

  def member?
    id == RoleType.member_id
  end
end
