class FavoritesController < ApplicationController
    before_action :logged_in_user
    
    def create
      post=Post.find(params[:post_id])
      #Application_controllerでsessions_helperをincludeしているので、このcontroller内でも以下のcurrent_userメソッドで、現在ログインしているユーザーのオブジェクトをreturnできる
      current_user.favorite(post)
      redirect_to post 
    end
    
    def destroy
      #post=Post.find(params[:post_id])
      #current_user.unfavorite(post)
      #Viewファイル内のlink_toで、paramsにpost_idを持たせる文法がわからなかったため、unfavoriteメソッドを使わず、直接idでfavoriteを探し、destroyを実行しました
        favorite=Favorite.find(params[:id])
        post=Post.find(favorite.post_id)
        favorite.destroy
      
      redirect_to post 
    end
    
end
