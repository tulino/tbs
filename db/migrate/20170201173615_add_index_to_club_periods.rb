class AddIndexToClubPeriods < ActiveRecord::Migration
  def change
    add_index :club_periods, [:club_id, :academic_period_id]
  end
end
