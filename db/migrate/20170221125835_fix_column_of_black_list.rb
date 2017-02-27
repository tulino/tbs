class FixColumnOfBlackList < ActiveRecord::Migration
  def change
    rename_column :black_lists, :approve, :approved
    change_column_default :black_lists, :approved, false
  end
end
