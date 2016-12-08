class Word < ApplicationRecord
  belongs_to :category
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers
  validates :content, presence: true,
    length: {maximum: 20}
  validates :content, uniqueness: true
  validate :must_have_corect_answer

  scope :alphabet, ->{order :content}
  scope :search_by_condition, ->condition do
    where "content LIKE ?", "%#{condition}%" if condition.present?
  end
  scope :search_by_category, ->category_id do
    where category_id: category_id if category_id.present?
  end
  scope :learned, ->user_id do
    where "id IN (SELECT word_id FROM results WHERE lesson_id IN
      (SELECT id FROM lessons WHERE user_id = ?))", user_id
  end
  scope :not_learned, ->user_id do
    where "id NOT IN (SELECT word_id FROM results WHERE lesson_id IN
      (SELECT id FROM lessons WHERE user_id = ?))", user_id
  end

  def must_have_corect_answer
    if answers.reject{|answer| !answer.is_correct?}.count == 0
      errors.add :answers, I18n.t("need_correct_answer")
    end
  end

  def self.create_word_variable condition, search_word, category_id, user_id
    case condition
    when I18n.t("all")
      Word.includes(:answers).search_by_category category_id
    when condition
      Word.includes(:answers).search_by_category category_id
        .send(condition, user_id)
    else
      Word.includes(:answers).search_by_condition search_word
    end.alphabet
  end
end
