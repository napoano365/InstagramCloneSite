class LikesController < ApplicationController
    before_action :logged_in_user
    
    def create
      post=Post.find(params[:post_id])
      #Application_controllerでsessions_helperをincludeしているので、このcontroller内でも以下のcurrent_userメソッドで、現在ログインしているユーザーのオブジェクトをreturnできる
      current_user.like(post)
      redirect_to post 
    end
    
    def destroy
      #post=Post.find(params[:post_id])
      #current_user.unfavorite(post)
      #Viewファイル内のlink_toで、paramsにpost_idを持たせる文法がわからなかったため、unlikeメソッドを使わず、直接idでlikeを探し、destroyを実行しました
        like=Like.find(params[:id])
        post=Post.find(like.post_id)
        like.destroy
      
      redirect_to post 
    end
    
end
