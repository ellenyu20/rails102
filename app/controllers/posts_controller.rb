class PostsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create]

  def edit
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    # 生成编辑文章的动态url路径
  end

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def update
    #@group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    #不需要第一句，原因待确认

    if @post.update(post_params)
      redirect_to account_posts_path, notice: "Update Success"
      #指向我发布的文章路径
    else
      render :edit
      #校验不为空
    end

  def destroy
      #@group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    @post.destroy
    flash[:alert] = "Post deleted"
    redirect_to account_posts_path
  end
end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
