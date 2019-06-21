require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @validuser = FactoryBot.create(:validuser)
      
  end
    
  describe "in 存在性テスト" do
    context "of [正常系]" do
      #username、email、passwordがあれば有効な状態であること
      it "is valid with a username, email, and password" do
          expect(@validuser).to be_valid
      end
    end
  
    context "of [準正常系]" do
      #usernameがなければ無効な状態であること
      it "is invalid without a username" do
        @validuser.username = nil
        @validuser.valid?
        expect(@validuser.errors[:username]).to include("can't be blank")
      end
      # emailがなければ無効な状態であること
      it "is invalid without a email" do
        @validuser.email = nil
        @validuser.valid?
        expect(@validuser.errors[:email]).to include("can't be blank")
      end
      # passwordがなければ無効な状態であること
      it "is invalid without a password" do
        @validuser.password = nil
        @validuser.valid?
      expect(@validuser.errors[:password]).to include("can't be blank")
      end
    end
  end

  describe "in 一意性テスト" do
    context "of [準正常系]" do
      # 重複したユーザーネームなら無効な状態であること
      it "is invalid with a duplicate username " do
        @validuser.save
        user = User.new(
          username: @validuser.username,
          email: "tester1@example.com",
          password: "dottle-nouveau-pavilion-tights-furze",
        )
        user.valid?
        expect(user.errors[:username]).to include("has already been taken")
      end
      # 重複したメールアドレスなら無効な状態であること
      it "is invalid with a duplicate email address" do
        @validuser.save
        user = User.new(
          username: "John",
          email: @validuser.email,
          password: "dottle-nouveau-pavilion-tights-furze",
        )
        user.valid?
        expect(user.errors[:email]).to include("has already been taken")
      end
    end  
  end

  describe "in クラスメソッドのテスト" do
    context "of [正常系]" do
      #ユーザーのemailを小文字に統一するメソッドの検証
      it "returns a user's downcased_email as a string" do
        @validuser.email = "JOHNdoe@ExamplE.coM"
        expect(@validuser.downcase_email).to eq "johndoe@example.com"
      end
    end
  end
end