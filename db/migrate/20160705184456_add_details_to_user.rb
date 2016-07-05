class AddDetailsToUser < ActiveRecord::Migration
  def change
    change_column :users, :country, :string, default: 'Spain'
  end
end
