class Address < ApplicationRecord
  belongs_to :user, optional: true

  validates :zip_code, :prefecture, :municipality, :address, presence: true
end
