class CreateMembers < ActiveRecord::Migration
  def change
    add_foreign_key :members, :knowledges, column: :instrument_id
  end
end
