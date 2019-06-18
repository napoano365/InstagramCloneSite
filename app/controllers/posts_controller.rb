class PostsController < ApplicationController
    
    def index
      @posts=Post.all.paginate(page: params[:page])
    end
    
    def show
        @user=User.new
        @post=Post.find(params[:id])
        @newcomment=Comment.new(post_id: @post.id, user_id: current_user.id)
        @comments=@post.comments
    end
    
    def new
        @post=Post.new
    end
    
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "post created!"
      redirect_to @post.user
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
    
    
      private
        def post_params
            params.require(:post).permit(:comment, :picture)
        end

    
end
