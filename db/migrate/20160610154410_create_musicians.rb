class CreateMusicians < ActiveRecord::Migration
  def change
    create_table :musicians do |t|

      t.timestamps null: false
    end
  end
end
