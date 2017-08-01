class RemoveVoteCountFromList < ActiveRecord::Migration
  def change
    remove_column :lists, :vote_count, :integer
  end
end
