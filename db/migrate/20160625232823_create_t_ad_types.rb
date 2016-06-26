class CreateTAdTypes < ActiveRecord::Migration
  def change
    create_table :t_ad_types do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
