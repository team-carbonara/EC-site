class Product < ApplicationRecord
  belongs_to :genre
  has_many :cart_products, dependent: :destroy
  has_many :order_products

  attachment :image

  validates :genre_id, presence:true
  validates :name, presence:true
  validates :description, presence:true
  validates :image, presence:true
  validates :price, presence:true

  def add_tax_price
    (self.price * 1.10).round
  end
end
