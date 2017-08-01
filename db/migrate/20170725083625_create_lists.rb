class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.integer :president_id
      t.integer :vice_president_id
      t.integer :accountant_id
      t.integer :secretary_id
      t.integer :member_one
      t.integer :member_two
      t.integer :member_three
      t.integer :vote_count, default: 0
      t.integer :selection_id

      t.timestamps null: false
    end
  end
end
