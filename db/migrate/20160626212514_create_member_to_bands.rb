class CreateMemberToBands < ActiveRecord::Migration
  def change
    create_table :member_to_bands do |t|
      t.string :city
      t.string :state
      t.string :country

      t.timestamps null: false
    end
  end
end
