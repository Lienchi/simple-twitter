class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  
  belongs_to :user
  has_many :replies, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def is_liked?(user)
    self.liked_users.include?(user)
  end

  def count_replies
    self.replies_count = Reply.where(tweet_id: self.id).size
    self.save
  end

  def count_likes
    self.likes_count = Like.where(tweet_id: self.id).size
    self.save
  end
end
