class CommentsController < ApplicationController
  def create
    @newcomment = Comment.new
    @newcomment.comment = params[:comment][:comment]
    @newcomment.user_id = params[:user_id]
    @newcomment.post_id = params[:post_id]
    if @newcomment.save
      redirect_to "/posts/#{@newcomment.post_id}"
    else
      redirect_to "/"
    end
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    flash[:success] = "Comment deleted"
    redirect_to root_url
  end
  
    #private

    #def comment_params
    #  params.require(:newcomment).permit(:comment, :user_id, :post_id)
    #end

end
