class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
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
  
  def new
    @user = User.new
  end
  
  def edit
    @user=User.find(params[:id])
  end
    
  def show
    @user=User.find(params[:id])
    @post=Post.new
    @posts = @user.posts.paginate(page: params[:page])
    
  end    

  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報が変更されました。"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    log_out
    flash[:success] = "ユーザー情報が削除されました。ご利用ありがとうございました。"
    redirect_to root_url
  end
  
    
  def password_change
    @user=User.find(params[:id])
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
  
  #facebooklogin用のコールバックを受けるアクション
  def auth_done
    user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])
    session[:user_id] = user.id
    flash[:success] = "ログインしました。"
    redirect_to root_url
  end
  
  def auth_failure
    flash[:danger] = "ログインに失敗しました。"
    redirect_to root_url
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :website, :profiletext, :tel, :sex)
    end
    
    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "この操作にはログインが必要です。"
        redirect_to login_url
      end
    end
        
    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
    
end
