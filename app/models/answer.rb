class Answer < ApplicationRecord
  belongs_to :word
  has_many :results, dependent: :destroy
  scope :alphabet, ->{order :content}
  scope :correct, ->{where is_correct: true}
end
