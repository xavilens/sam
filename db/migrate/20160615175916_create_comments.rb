class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :post, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.text :cuerpo, null: false
      t.boolean :editado,default:false, null: false

      t.timestamps null: false
    end
  end
end
