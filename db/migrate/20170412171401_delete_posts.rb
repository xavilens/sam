class DeletePosts < ActiveRecord::Migration
  def change
    remove_foreign_key :comments, :posts
    remove_foreign_key :comments, :users
    remove_index :comments, name: "index_comments_on_post_id"
    remove_index :comments, name: "index_comments_on_user_id"
    drop_table :comments

    remove_foreign_key :main_posts, :posts
    remove_index :main_posts, name: "index_main_posts_on_post_id"
    drop_table :main_posts

    remove_foreign_key :posts, :users
    remove_index :posts, name: "index_posts_on_user_id"
    drop_table :posts
  end
end
