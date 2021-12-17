class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_products
  
  enum production_status: {
     "着手不可":0, "製作待ち":1, "製作中":2, "製作完了":3
  }
  
  enum payment_method: {
     "クレジット":true, "銀行振込":false
  }
end
