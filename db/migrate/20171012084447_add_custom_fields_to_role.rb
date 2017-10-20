class AddCustomFieldsToRole < ActiveRecord::Migration
  def change
    add_column :roles, :club_id, :integer
    add_column :roles, :membership_start_date, :date
    add_column :roles, :membership_end_date, :date
  end
end
