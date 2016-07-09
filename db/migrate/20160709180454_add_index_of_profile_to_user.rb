class AddIndexOfProfileToUser < ActiveRecord::Migration
  def change
    # change_column :users, :profileable_id, :integer, uniqueness: {scope: :profileable_type}
    change_column :users, :country, :string, default: nil
  end
end
