class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  has_many :answers, through: :results
  has_many :words, through: :results
  accepts_nested_attributes_for :results
  before_create :create_results

  def score
    answers.correct.size
  end

  private
  def create_results
    self.category.words.random.limit(Settings.limit_question).each do |word|
      self.results.build word_id: word.id
    end
  end
end
