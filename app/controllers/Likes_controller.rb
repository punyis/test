class LikesController < ApplicationController
  def create
    post = Post.find(params[:id])
    post.likes.create(user: current_user)
    redirect_to posts_path, notice: 'You liked this post.'
  end

  def destroy
    @post = Post.find(params[:id])
    @like = @post.likes.find_by(user_id: current_user.id)

    if @like
      @like.destroy  # ลบการ like
      redirect_to @post, notice: "You have unliked the post."
    else
      redirect_to @post, alert: "You haven't liked this post."
    end
  end
end
