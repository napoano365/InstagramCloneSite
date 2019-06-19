require 'rails_helper'

RSpec.describe User, type: :model do
#存在性テスト
  #[正常系]
  # username、email、passwordがあれば有効な状態であること
  it "is valid with a username, email, and password" do
    user = User.new(
      username: "Sumner365",
      email: "tester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    expect(user).to be_valid
  end
  
  #[準正常系]
  # usernameがなければ無効な状態であること
  it "is invalid without a username" do
    user = User.new(username: nil)
    user.valid?
    expect(user.errors[:username]).to include("can't be blank")
  end
  # emailがなければ無効な状態であること
  it "is invalid without a email" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
  # passwordがなければ無効な状態であること
  it "is invalid without a password" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end
  
#一意性テスト
  #[準正常系]
    # 重複したユーザーネームなら無効な状態であること
  it "is invalid with a duplicate username " do
    User.create(
      username: "Joe",
      email: "tester1@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    user = User.new(
      username: "Joe",
      email: "tester2@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    user.valid?
    expect(user.errors[:username]).to include("has already been taken")
  end
  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    User.create(
      username: "Joe",
      email: "tester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    user = User.new(
      username: "Jane",
      email: "tester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
  
#クラスメソッドのテスト
  #ユーザーのemailを小文字に統一するメソッドの検証
  #[正常系]
  it "returns a user's downcased_email as a string" do
    user = User.new(
      username: "John",
      email: "JOHNdoe@ExamplE.coM",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    expect(user.downcase_email).to eq "johndoe@example.com"
  end

end