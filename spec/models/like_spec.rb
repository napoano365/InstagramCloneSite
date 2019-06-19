require 'rails_helper'

RSpec.describe Like, type: :model do

#マッチャーの記述方法がわからないためテスト記載を保留中

  #[正常系]
  # 二人のユーザーが同じ投稿にいいねをすることは許可すること
  it "allows two users to share a like post_id" do
    user = User.create(
      username: "Joe",
      email: "joetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )

    user.likes.create(
      post_id: 1,
    )

    other_user = User.create(
      username: "Jane",
      email: "janetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )

    other_like = other_user.likes.build(
      post_id: 1,
    )
    
    expect(other_like).to be_valid
  end

  #[準正常系]
  # ユーザー単位では同じ投稿にいいねを許可しないこと
    it "does not allow duplicate like post_id per user" do
    user = User.create(
      username: "Joe",
      email: "joetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )

    user.likes.create(
      post_id: 1,
    )

    new_like = user.likes.build(
      post_id: 1,
    )
    
    new_like.valid?
    expect(new_like.errors[:post_id]).to include("user can make only a like in a post")
   end
   
end
