class AddIndexToClubPeriods < ActiveRecord::Migration
  def change
    add_index :club_periods, %i[club_id academic_period_id]
  end
end
