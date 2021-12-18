class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_products

  enum status: {
     入金待ち:0, 製作待ち:1, 発送準備:2, 発送済み:3
  }

  enum payment_method: {
     credit_card:0, transfer:1
  }
end
