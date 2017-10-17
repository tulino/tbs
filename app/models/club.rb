class Club < ActiveRecord::Base
  mount_uploader :logo, ImageUploader
  belongs_to :club_category
  has_one :club_contact, dependent: :destroy
  has_one :club_setting, dependent: :destroy
  has_many :club_periods, dependent: :destroy
  has_many :users, through: :roles_users
  has_many :club_slides
  has_many :black_list

  def self.search(query)
    where('lower(name) like ?', "%#{query}%".downcase)
  end

  def active_club_period(academic_period_id = nil)
    academic_period_id ||= AcademicPeriod.active_period_id
    club_periods.find_by(academic_period_id: academic_period_id)
  end

  def members
    Role.where(
      club_id: id,
      status: 1,
      role_type_id: RoleType.member_id
    )
  end

  def all_members
    Role.where(
      club_id: id,
      role_type_id: RoleType.member_id
    )
  end
end
