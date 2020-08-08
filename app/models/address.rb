class Address < ApplicationRecord
  belongs_to :user, optional: true

  validates :zip_code,
            presence: true,
            #郵便番号に一致する文字列のみ可
            format: { with: /\A\d{3}[-]\d{4}\z/}
  validates :prefecture, :municipality, :address, presence: true
  validates :phone_number, allow_blank: true, #空でも可
            #ハイフンなし10桁か11桁のみ可
            format: { with: /\A\d{10,11}\z/}
end
