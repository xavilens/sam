class DeviseCreateDelegatedUsers < ActiveRecord::Migration
  def change
    create_table :delegated_users do |t|
      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.integer :delegated_user
      t.integer :current_user
      t.boolean :activo

      t.timestamps null: false
    end

    add_index :delegated_users, :delegated_user
    add_index :delegated_users, :current_user, unique: {scope: :delegated_user}

    add_foreign_key :delegated_users, :users, column: :delegated_user
    add_foreign_key :delegated_users, :users, column: :current_user
  end
end
