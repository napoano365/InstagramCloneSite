require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @validuser = FactoryBot.build(:validuser)
    @other_validuser = FactoryBot.build(:other_validuser)
    #以下の@validuserはuserファクトリで定義しDRY化。ただDRYにしすぎで確認に手間がかかる場合は
    #以下の記述を復活させられるようコメントアウトにしています。
    #@validuser = User.new(
    #  username: "testuser",
    #  email: "testuser@gmail.com",
    #  password: "testpass",
    #)
    #@other_validuser = User.new(
    #  username: "othertestuser",
    #  email: "othertestuser@gmail.com",
    #  password: "testpass",
    #)
  end

  describe "in 一意性のテスト" do
    context "of [正常系]" do
      # 二人のユーザーが同じ投稿にいいねをすることは許可すること
      it "allows two users to share a like post_id" do
        @validuser.save
        @validuser.likes.create(
          post_id: 1,
        )
        @other_validuser.save
        other_like = @other_validuser.likes.build(
          post_id: 1,
        )
        expect(other_like).to be_valid
      end
    end
    context "of [準正常系]" do
      # ユーザー単位では同じ投稿にいいねを許可しないこと
      it "does not allow duplicate like post_id per user" do
        @validuser.save
        @validuser.likes.create(
          post_id: 1,
        )
        new_like = @validuser.likes.build(
          post_id: 1,
        )
        new_like.valid?
        expect(new_like.errors[:post_id]).to include("user can make only a like in a post")
      end
    end
  end
end