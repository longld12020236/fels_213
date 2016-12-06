class Category < ApplicationRecord
  has_many :lessons, dependent: :destroy
  has_many :words, dependent: :destroy

  scope :alphabet, ->{order :title}
end
