FactoryBot.define do
  factory :comment do
    sequence(:comment) { |n| "viewer comment #{n}" }
    association :post
    user_id {post.user_id}
  end
end
