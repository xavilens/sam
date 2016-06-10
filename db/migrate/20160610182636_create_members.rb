class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :band, index: true, foreign_key: true
      t.references :musician, index: true, foreign_key: true
      t.references :instrument, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
