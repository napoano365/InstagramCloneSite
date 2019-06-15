class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :comment, presence: true, length: { maximum: 140 }
  validate  :picture_size
  
  def already_favorited?(user)
    favorited_users.include?(user)
  end
  
  def already_liked?(user)
    liked_users.include?(user)
  end
  
  def self.search(search) #ここでのself.はPost.を意味する
    if search
      where(['comment LIKE ?', "%#{search}%"]) #検索とcommentの部分一致を表示。Post.は省略
    else
      all #全て表示。Post.は省略
    end
  end
  
   private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
  
  
  
end
