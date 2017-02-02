class RoleType < ActiveRecord::Base
  has_many :roles
  scope :club_member_type_ids, -> { where(name: ['Başkan', 'Üye']).pluck(:id) }
end
