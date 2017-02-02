class RoleType < ActiveRecord::Base
  has_many :roles
  scope :club_member_type_ids, -> { where(name: ['Başkan', 'Üye']).pluck(:id) }
  scope :president_id, -> { find_by(name: 'Başkan').id }
  scope :dean_id, -> { find_by(name: 'Dean').id }
end
