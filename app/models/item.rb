class Item < ApplicationRecord

  validates :item_name, :item_image, :seller, :category, :size, :condition, :postage_player,
  :postage_type, :prefecture_id, :shipping_date, :price, :introduction, presence: true

  mount_uploader :item_image, ItemImageUploader

  belongs_to :prefecture, optional: true
end
