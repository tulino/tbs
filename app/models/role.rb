class Role < ActiveRecord::Base
  belongs_to :role_type
  belongs_to :club_period
  belongs_to :user
  belongs_to :faculty
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
    Role.find_by(club_period_id: club_period_id, role_type_id: RoleType.find_by(name: 'Baskan').id)
  end
end
