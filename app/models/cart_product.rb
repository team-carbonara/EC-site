class CartProduct < ApplicationRecord
  belongs_to :customer
  belongs_to :product
  
def subtotal #小計の式
    self.add_tax_price * quantity
end
end
