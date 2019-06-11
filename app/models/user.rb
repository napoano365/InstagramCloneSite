class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy                                
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  def downcase_email
    self.email = email.downcase
  end
  
  # ユーザーをフォローする
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # ユーザーをアンフォローする
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
  
  #投稿をお気に入りする
  def favorite(post)
    favorites.create(post_id: post.id)
  end
  
  #投稿をお気に入り解除する
  def unfavorite(post)
    favorites.find_by(post_id: post.id).destroy
  end
  
  #現在のユーザーがお気に入りしてたらtrueを返す
  def already_favorited?(post)
    favorites.include?(post)
  end
  
  # ユーザーのステータスフィードを返す
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end
end
