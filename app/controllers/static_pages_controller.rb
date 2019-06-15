class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @post  = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page]).search(params[:search])
      @comments
      @newcomment=Comment.new
    end
  end

  def help
  end
end
