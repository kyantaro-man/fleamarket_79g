class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  validates :password, length: {minimum: 7},
            #半角英数字のみ可
            format: { with: /\A[a-z0-9]+\z/i}
  validates :email, 
            uniqueness: {case_sensitive: false},  #重複不可
            #@とドメインを含んでいるか
            format: {with: /\A\S+@\S+\.\S+\z/}
  validates :family_name, :first_name, presence: true,
            #全角ひらがなカタカナ、漢字のみ可
            format: {with: /\A[ぁ-んァ-ン一-龥]/}
  validates :kana_family_name, :kana_first_name, presence: true,
            #全角ひらがなのみ可
            format: {with: /\A[ぁ-んー－]+\z/}
  validates :birth_year, :birth_month, :birth_day, presence: true,
            #半角数字のみ可
            format: {with: /\A[0-9]+\z/}

  has_one :address
  has_many :items
  has_many :cards
  has_many :comments
end
