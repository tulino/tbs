module ClubsHelper
  def member_program_error?(club, user)
    return unless user.present?
    club.club_setting.program_id != user.program_code
  end

  def member_count_error?(club, club_members)
    club_members_count = club_members.nil? ? 0 : club_members.count - 1
    max_user = club.club_setting.nil? ? 150 : club.club_setting.max_user
    club_members_count > max_user
  end
end
