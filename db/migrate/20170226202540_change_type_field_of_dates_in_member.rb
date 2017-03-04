class ChangeTypeFieldOfDatesInMember < ActiveRecord::Migration
  def change
    change_column :members, :delete_date, :date
    change_column :members, :join_date, :date
  end
end
