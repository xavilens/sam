class CreateRehearsalStudioUsers < ActiveRecord::Migration
  def change
    create_table :rehearsal_studio_users do |t|
      t.references :rehearsal_studio, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false, unique: {scope: :rehearsal_studio_id}

      t.timestamps null: false
    end
  end
end
