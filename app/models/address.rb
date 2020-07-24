class Address < ApplicationRecord
  belongs_to :user

  validates :zip_code, :prefecture, :municipality, :address, presence: true
end
