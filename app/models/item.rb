class Item < ApplicationRecord
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :item_name, :category_id, :condition_id, :postageplayer_id,
   :shippingdate_id, :price, :introduction, :prefecture_id, presence: true

  belongs_to :prefecture, optional: true
  belongs_to :category, optional: true
  

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :postageplayer
  belongs_to_active_hash :shippingdate
end
