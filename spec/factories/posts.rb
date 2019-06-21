FactoryBot.define do
  factory :post do
    sequence(:comment) { |n| "Poster comment #{n}" }
    
    #以下の指定で、postデータを生成するとき、自動で、postしたuserのデータを、validuserのファクトリから作成する
    #association :アソシエーション名, factory: :ファクトリ名
    association :user, factory: :validuser
  end
end
