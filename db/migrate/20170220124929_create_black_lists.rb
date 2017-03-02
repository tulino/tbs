class CreateBlackLists < ActiveRecord::Migration
  def change
    create_table :black_lists do |t|
      t.integer :club_id
      t.integer :user_id
      t.boolean :approve
      t.string :explanation

      t.timestamps null: false
    end
  end
end
