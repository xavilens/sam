class CreateTAdItems < ActiveRecord::Migration
  def change
    create_table :t_ad_items do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
