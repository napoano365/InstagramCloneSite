require 'rails_helper'

RSpec.describe Comment, type: :model do
  
  #以下は、comment作成時どのuserのどのpostに紐づけられたか確認する際にコードインして利用する
  #it "generate associated data from a factory" do
  #  comment = FactoryBot.create(:comment)
  #  puts "このコメントは投稿id#{comment.post_id}に行われています"
  #  puts "コメント先の投稿の作成者idは#{comment.post.user_id}です"
  #end
end
