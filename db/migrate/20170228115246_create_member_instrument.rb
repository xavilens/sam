class CreateMemberInstrument < ActiveRecord::Migration
  def change
    create_table :member_instruments do |t|
      t.references :member, index: true, foreign_key: true
      t.references :instrument, index: true, foreign_key: true
    end
  end
end
