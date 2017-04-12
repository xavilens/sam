class DropRehearsalStudioRelated < ActiveRecord::Migration
  def change
    drop_table :rehearsal_studio_reviews

    remove_foreign_key :rehearsal_studio_users, :users
    remove_foreign_key :rehearsal_studio_users, :rehearsal_studios
    remove_index :rehearsal_studio_users, name: "index_rehearsal_studio_users_on_user_id"
    remove_index :rehearsal_studio_users, name: "index_rehearsal_studio_users_on_rehearsal_studio_id"
    drop_table :rehearsal_studio_users

    remove_foreign_key :rehearsal_studios, column: "creator_id"
    remove_index :rehearsal_studios, name: "index_rehearsal_studios_on_creator_id"
    drop_table :rehearsal_studios
  end
end
