class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    respond_to do |format|
      format.html { redirect_to product_path(params[:product_id])  }
      format.json
    end
  end

  def show
  end

  def comment_params
    #ユーザーログイン機能が出来たらuser_id:current_user.idにする
    params.require(:comment).permit(:content).merge(user_id:current_user.id, product_id:params[:product_id])
  end

end
