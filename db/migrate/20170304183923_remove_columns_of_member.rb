class RemoveColumnsOfMember < ActiveRecord::Migration
  def change
    remove_column :members, :join_date
    remove_column :members, :delete_date
  end
end
