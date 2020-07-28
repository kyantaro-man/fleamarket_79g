class Item < ApplicationRecord
  validates :item_name, :category_id, :brand, :condition_id, :postageplayer_id,
   :shippingdate_id, :price, :introduction, :prefecture_id, presence: true
  mount_uploader :item_image, ItemImageUploader
  belongs_to :prefecture, optional: true

  has_many :item_images
  accepts_nested_attributes_for :item_images

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :postageplayer
  belongs_to_active_hash :shippingdate
end
