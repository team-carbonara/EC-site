class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :genre, foreign_key: true
      t.string :name, null: false
      t.text :description, null: false
      t.string :image_id, null: false
      t.integer :price, null: false
      t.boolean :sale_status, null: false

      t.timestamps
    end
  end
end
