class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_products

  validates :post_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  # validates :address, presence: true
  enum status: {
     入金待ち:0, 製作待ち:1, 発送準備:2, 発送済み:3
  }

  enum payment_method: {
     クレジット:0, 銀行振込:1
  }


end