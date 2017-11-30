class AddAdvisorIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :advisor_id, :integer
  end
end
