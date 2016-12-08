class User < ApplicationRecord
  has_many :lessons, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  before_save {self.email = email.downcase}
  validates :name, presence: true, length: {maximum: Settings.max_name}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   true, length: {maximum: Settings.max_email},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.min_password},
    allow_nil: true
  has_secure_password

  scope :alphabet, ->{order :name}

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    follow_user = active_relationships.find_by followed_id: other_user.id
    if follow_user
      follow_user.destroy
    else
      false
    end
  end

  def following? other_user
    following.include? other_user
  end
end
