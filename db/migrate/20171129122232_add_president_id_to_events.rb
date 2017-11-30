class AddPresidentIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :president_id, :integer
  end
end
