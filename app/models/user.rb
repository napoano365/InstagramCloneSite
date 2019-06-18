class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :likes, dependent: :destroy
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
  validates :password, presence: true, length: { minimum: 6 },allow_nil: true
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
  
    #投稿をいいねする
  def like(post)
    likes.create(post_id: post.id)
  end
  
  #投稿のいいねを解除する
  def unlike(post)
    likes.find_by(post_id: post.id).destroy
  end
  
  #現在のユーザーがいいねしてたらtrueを返す
  def already_liked?(post)
    likes.include?(post)
  end
  
  # ユーザーのステータスフィードを返す
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end
  
  #Facebookログイン機能_コールバックされるユーザデータを処理する
  def self.find_or_create_from_auth_hash(auth_hash)
    uid = auth_hash['uid']
    provider = auth_hash['provider']
    
    #既存ユーザーを見つけてくるか、新しくuserインスタンスを作成
    user = User.find_or_create_by(uid: uid, provider: provider)

    #ユーザー情報をFBから帰ってきた情報を正としてUpdateする
    user.name = auth_hash['info']['name'] || ''
    user.email = auth_hash['info']['email'] || 'none'
    user.username = auth_hash['info']['name'] || ''
    user.image= auth_hash['info']['image'] || ''
    user.password = SecureRandom.urlsafe_base64

    #以下のデータは取得してもuserモデルにカラムを準備していないため、コメントアウト
    #user.access_token = auth_hash['credentials']['token']
    #user.location = auth_hash['extra']['raw_info']['location'] || ''
    #user.company = auth_hash['extra']['raw_info']['company'] || ''
    #user.member_since = auth_hash['extra']['raw_info']['created_at'] || ''

    #後置if分の中で、user.saveを実行して、データベースに保存かけてるし、加えてそれが成功したときに明示的にuserオブジェクトを関数の処理結果としてreturnするようにしている。
    #なのでもしmodelのバリデーションでエラーになったら、処理が止まるはず。
    if user.save
      user
    else
      redirect_to '/auth/failure'
    end
  end
end