FactoryBot.define do
  #以下、ファクトリの継承を用いたバージョン。入れ子構造でuserを継承しているのでファクトリ名が:userでなくても、class名を指定しなくてよくなっている。
  factory :user do
    password "testpass"
    
    factory :validuser do
      username "testuser"
      email "testuser@gmail.com"
      #emailをシーケンシャルに登録する場合のみ以下の設定を利用する
      #sequence(:email) { |n| "testuser#{n}@gmail.com" }
    end
    
    factory :other_validuser do
      username "othertestuser"
      email "othertestuser@gmail.com"
    end
  end
end

  #以下、ファクトリの継承を実施していないバージョン。classの明示方法を確認するためのレガシーコード。
  #factory :validuser, class: User do
  #  username "testuser"
  #  email "testuser@gmail.com"
  #  #emailをシーケンシャルに登録する場合のみ以下の設定を利用する
  #  #sequence(:email) { |n| "testuser#{n}@gmail.com" }
  #  password "testpass"
  #end
  
  #以下のように同じmodelに対し、異なる名前のfactoryを準備するにはどうすればよいか検討中 => 以下のようにclassを明示する。
  #factory :ファクトリ名, class: クラス名 do
  #factory :other_validuser, class: User do
  #  username "othertestuser"
  #  email "othertestuser@gmail.com"
  #  password "testpass"
  #end
