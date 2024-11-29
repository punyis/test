class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :correct_user, only: [:edit, :update, :destroy]
    
  
    def index
      if params[:search].present?
        @posts = Post.where('title LIKE ?', "%#{params[:search]}%").order(created_at: :desc)
      else
        @posts = Post.all.order(created_at: :desc)
      end
    end
  
    def new
      @post = Post.new
    end
  
    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        redirect_to root_path, notice: "Post created successfully."
      else
        render :new
      end
    end
  
    def show
      @post = Post.find(params[:id])
      if @post.nil?
        redirect_to posts_path, alert: "Post not found."
      else
        @comment = Comment.new # สำหรับฟอร์มคอมเมนต์
      end
    end
  
    def edit
      # @post จะถูกตั้งค่าโดยก่อนหน้านี้ใน set_post
    end
  
    def update
      if @post.update(post_params)
        redirect_to @post, notice: 'Post was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

  
  
    private
  
    def set_post
      @post = Post.find(params[:id])
    end
  
    def correct_user
      # ตรวจสอบว่าโพสต์นี้ถูกสร้างโดยผู้ใช้ที่ลงชื่อเข้าใช้งานหรือไม่
      redirect_to(posts_path, alert: "You are not authorized to edit this post.") unless @post.user == current_user
    end
  
    def post_params
      params.require(:post).permit(:title, :content)
    end
  end
  