class AddDeleteDateToMember < ActiveRecord::Migration
  def change
    add_column :members, :delete_date, :datetime
    add_column :members, :join_date, :datetime
  end
end
