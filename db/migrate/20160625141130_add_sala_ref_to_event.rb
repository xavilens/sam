class AddSalaRefToEvent < ActiveRecord::Migration
  def change
    add_reference :events, :sala, index: true, foreign_key: true
  end
end
