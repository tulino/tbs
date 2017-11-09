class ChangeStatusTypeInRoles < ActiveRecord::Migration
  def change
    change_column :roles, :status, :integer, default: 0
  end
end
