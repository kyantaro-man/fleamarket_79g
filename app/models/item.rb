class Item < ApplicationRecord
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :item_name, :category_id, :condition_id, :postageplayer_id,
   :shippingdate_id, :price, :introduction, :prefecture_id, presence: true

  belongs_to :prefecture, optional: true
  belongs_to :category, optional: true
  # 1つ前のitemを取得するためのインスタンスメソッド   @item.previousで呼び出せます
  def previous
    Item.where("id < ?", self.id).order("id DESC").first       #@itemよりidが小さいレコードを降順で並べ最初を取得
  end
  # 1つ後のitemを取得するためのインスタンスメソッド   @item.nextで呼び出せます
  def next
    Item.where("id > ?", self.id).order("id ASC").first        #@itemよりidが大きいレコードを昇順で並べ最初を取得
  end
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :postageplayer
  belongs_to_active_hash :shippingdate
end
