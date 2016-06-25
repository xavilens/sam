class AddUniquenessScopeToSalaUser < ActiveRecord::Migration
  def change
    change_column :sala_users, :sala_id, :integer, unique: {scope: :user_id}
  end
end
