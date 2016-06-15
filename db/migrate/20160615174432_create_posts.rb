class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :titulo, null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.text :cuerpo, null: false
      t.boolean :publicado, default:false, null: false
      t.boolean :editado, default:false, null: false

      t.timestamps null: false
    end
  end
end
