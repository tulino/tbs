module ClubsHelper
  def member_program_error?(club, user)
    return unless user.present?
    club.club_category.vocational_club? &&
      club.club_setting.program_id != user.program_code
  end
end
