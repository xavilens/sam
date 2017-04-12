class DropActivityRelated < ActiveRecord::Migration
  def change
    remove_foreign_key :activities, :users
    remove_foreign_key :activities, :activity_types
    remove_index :activities, name: "index_activities_on_activity_type_id"
    remove_index :activities, name: "index_activities_on_user_id"
    drop_table :activities

    drop_table :activity_types
  end
end
