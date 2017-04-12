class DropSalaTableAndRelated < ActiveRecord::Migration
  def change
    remove_foreign_key :sala_users, :salas
    remove_foreign_key :sala_users, :users
    remove_index :sala_users, name: "index_sala_users_on_sala_id"
    remove_index :sala_users, name: "index_sala_users_on_user_id"
    drop_table :sala_users

    remove_foreign_key :sala_reviews, :salas
    remove_foreign_key :sala_reviews, :users
    remove_index :sala_reviews, name: "index_sala_reviews_on_sala_id"
    remove_index :sala_reviews, name: "index_sala_reviews_on_user_id"
    drop_table :sala_reviews

    remove_foreign_key :sala_genres, :salas
    remove_foreign_key :sala_genres, :genres
    remove_index :sala_genres, name: "index_sala_genres_on_genre_id"
    remove_index :sala_genres, name: "index_sala_genres_on_sala_id"
    drop_table :sala_genres

    remove_foreign_key :salas, column: "creator_id"
    remove_foreign_key :events, :salas
    remove_index :salas, name: "index_salas_on_creator_id"
    remove_index :events, name: "index_events_on_sala_id"
    drop_table :salas
  end
end
