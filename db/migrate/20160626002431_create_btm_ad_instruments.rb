class CreateBtmAdInstruments < ActiveRecord::Migration
  def change
    create_table :btm_ad_instruments do |t|
      t.references :band_to_members, null: false
      t.references :instruments, null: false, unique: {scope: :band_to_member_id}

      t.timestamps null: false
    end
  end
end
