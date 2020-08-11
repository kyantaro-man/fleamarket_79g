class Image < ApplicationRecord
  validates :src, presence: true
  belongs_to :item
  mount_uploader :src, ImageUploader
end
