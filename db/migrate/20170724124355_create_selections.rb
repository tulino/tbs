class CreateSelections < ActiveRecord::Migration
  def change
    create_table :selections do |t|
      t.datetime :start_list_creation_date
      t.datetime :end_list_creation_date
      t.boolean :allow_list_creation
      t.datetime :start_selection_date
      t.datetime :end_selection_date
      t.boolean :allow_selection

      t.timestamps null: false
    end
  end
end
