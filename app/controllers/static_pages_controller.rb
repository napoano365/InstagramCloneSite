class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @post  = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @newcomment=Comment.new(post_id: @post.id, user_id: current_user.id)
    end
  end

  def help
  end
end
