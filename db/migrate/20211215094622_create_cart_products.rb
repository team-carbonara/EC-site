class CreateCartProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_products do |t|
      t.references :product, foreign_key: true
      t.references :customer, foreign_key: true
      t.integer :quantity, null: false
      t.timestamps
    end
  end
end
