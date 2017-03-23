module ClubsHelper
  def member_program_error?(club, user)
    return unless club.club_category.vocational_club?
    user_program_id = user.try(:profile).try(:program_id)
    program_id = club.club_setting.program_id
    club_program_ids = program_id.present? && program_id.split(/\s*,\s*/)
    return true unless user_program_id.present? && club_program_ids.present?
    !club_program_ids.include?(user_program_id)
  end
end
