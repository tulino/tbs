class Role < ActiveRecord::Base
  enum status: { pasif: 0, aktif: 1, red: 2}
  belongs_to :role_type
  belongs_to :club_period
  belongs_to :user
  belongs_to :faculty

   # scopes
   scope :all_pasif_members, -> { where(status: 0) }
   scope :rejected_members, -> { where(status: 2) }

  def rol_name
    if club
      if club_exception
        role_type.name + ' - ' + club.name + ' / ' + club_exception.academic_period.name
      else
        role_type.name + ' - ' + club.name
      end
    else
      role_type.name
    end
  end

  def self.president?(club_period_id)
    Role.find_by(club_period_id: club_period_id,
                 role_type_id: RoleType.president_id)
  end

  def self.advisor?(club_period_id)
    Role.find_by(club_period_id: club_period_id,
                 role_type_id: RoleType.advisor_id)
  end
end
