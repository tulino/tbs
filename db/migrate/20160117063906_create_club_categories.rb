class CreateClubCategories < ActiveRecord::Migration
  def change
    create_table :club_categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
