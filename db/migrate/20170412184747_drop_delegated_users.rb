class DropDelegatedUsers < ActiveRecord::Migration
  def change
    remove_foreign_key :delegated_users, column: "current_user"
    remove_foreign_key :delegated_users, column: "delegated_user"
    remove_index :delegated_users, name: "index_delegated_users_on_current_user"
    remove_index :delegated_users, name: "index_delegated_users_on_delegated_user"
    drop_table :delegated_users
  end
end
