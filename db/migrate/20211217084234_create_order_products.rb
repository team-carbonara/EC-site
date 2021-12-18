class CreateOrderProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :order_products do |t|
      t.references :product, foreign_key: true
      t.references :order, foreign_key: true
      t.integer  :price, null: false
      t.integer :quantity, null: false
      t.integer :production_status, null: false
      t.timestamps
    end
  end
end