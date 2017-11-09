class ClubPeriod < ActiveRecord::Base
  belongs_to :academic_period
  has_one :club_board_of_director
  has_one :club_board_of_supervisory
  has_one :advisor
  has_one :assistant_consultant
  has_many :announcements
  has_many :events
  has_many :event_requests
  has_many :roles
  belongs_to :club

  # scopes
  scope :all_active_period_ids, -> { where(academic_period_id: AcademicPeriod.active_period_id).pluck(:id) }

  def academic_period_name
    club.name + ' / ' + academic_period.name
  end

  def club_members
    Role.where(
      club_period_id: id,
      role_type_id: RoleType.member_id,
      status: 1
    )
  end

  def self.all_members_count_by_club_period(club_ids)
    academic_period_id = AcademicPeriod.active_period_id
    period_ids = ClubPeriod.where(
      club_id: club_ids,
      academic_period_id: academic_period_id
    ).pluck(:id)
    Role.where(
      club_period_id: period_ids,
      role_type_id: RoleType.member_id
    ).group(:club_period_id).count
  end

  def president
    roles.find_by(role_type_id: RoleType.president_id).try(:user)
  end

  def advisor
    roles.find_by(role_type_id: RoleType.advisor_id).try(:user)
  end

  def vice_advisor
    roles.find_by(role_type_id: RoleType.vise_advisor_id).try(:user)
  end
end
