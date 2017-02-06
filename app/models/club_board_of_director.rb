class ClubBoardOfDirector < ActiveRecord::Base
  belongs_to :club_period
  belongs_to :president, class_name: 'User', foreign_key: 'president_id'
  belongs_to :vice_president, class_name: 'User', foreign_key: 'vice_president_id'
  belongs_to :accountant, class_name: 'User', foreign_key: 'accountant_id'
  belongs_to :secretary, class_name: 'User', foreign_key: 'secretary_id'
  belongs_to :member_first, class_name: 'User', foreign_key: 'member_one'
  belongs_to :member_second, class_name: 'User', foreign_key: 'member_two'
  belongs_to :member_third, class_name: 'User', foreign_key: 'member_two'
  
  scope :all_cbo_directors, -> { where(club_period_id: ClubPeriod.all_active_period_ids) }
  scope :board_type, -> { :cbod }
end
