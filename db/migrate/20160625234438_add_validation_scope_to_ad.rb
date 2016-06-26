class AddValidationScopeToAd < ActiveRecord::Migration
  def change
    change_column :ads, :adeable_type, :string, unique: {scope: :adeable_id}
  end
end
