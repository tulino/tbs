class AddReferenceToSelection < ActiveRecord::Migration
  def change
    add_column :selections, :club_id, :integer
  end
end
