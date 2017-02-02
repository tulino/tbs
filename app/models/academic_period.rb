class AcademicPeriod < ActiveRecord::Base
  has_many :club_periods
  scope :active_period_id, -> { find_by(is_active: true).id }

  def self.academic_periods_excep(academic_period)
    where.not(id: academic_period)
  end
end
