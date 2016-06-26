class CreateBandToMembers < ActiveRecord::Migration
  def change
    create_table :band_to_members do |t|

      t.timestamps null: false
    end
  end
end
