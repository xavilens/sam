class CreateMembersInstruments < ActiveRecord::Migration
  def change
    # Por equivocación hicimos antes la creación de la tabla
    change_table :members_instruments do |t|
      # t.references :member, index: true, foreign_key: true
      # t.references :instrument, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
