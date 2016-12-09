class Result < ApplicationRecord
  belongs_to :lesson, optional: true
  belongs_to :answer
  belongs_to :word
end
