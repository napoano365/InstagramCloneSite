class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end
    
  def show
    @user=User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
    
  end    
  def edit
    @user=User.first
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ようこそ InstaClone へ！"
      redirect_to @user
    else
      render 'new'
    end
  end
    
  def password_change
    @user=User.first
  end
    
  def following
    @title = "フォロー中"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers 
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  #action sample
  #def auth_done
  #  facebook_id = request.env['omniauth.auth']['extra']['raw_info']['id']
  #  name = request.env['omniauth.auth']['extra']['raw_info']['name']
  #  gender = request.env['omniauth.auth']['extra']['raw_info']['gender']
  #  redirect_to :root
  #end
  
  private

    def user_params
      params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
    end
        
    
end
