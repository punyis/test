class LikesController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @post = Post.find(params[:post_id]) # ใช้ params[:post_id] เพื่อหาผู้โพสต์
      unless @post.likes.exists?(user_id: current_user.id)
        @post.likes.create(user_id: current_user.id)
      end
      redirect_to @post
    end
  
    def destroy
      @post = Post.find(params[:post_id]) # ใช้ params[:post_id] เพื่อหาผู้โพสต์
      @post.likes.find_by(user_id: current_user.id)&.destroy
      redirect_to @post
    end
  end
  