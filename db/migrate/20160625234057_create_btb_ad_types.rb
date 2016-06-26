class CreateBtbAdTypes < ActiveRecord::Migration
  def change
    create_table :btb_ad_types do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
