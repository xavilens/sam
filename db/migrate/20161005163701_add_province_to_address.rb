class AddProvinceToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :province, :string
  end
end
