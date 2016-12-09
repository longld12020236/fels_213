class Word < ApplicationRecord
  belongs_to :category
  has_many :answers, dependent: :destroy
  scope :random, ->{order "RANDOM()"}
  scope :alphabet, ->{order :content}
end
