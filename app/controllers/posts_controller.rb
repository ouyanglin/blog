class PostsController < ApplicationController
  def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_path
    else
      flash[:error] = "Omo! There was an error"
      redirect_to 'posts/new'
    end
  end

  def destroy
  end

  def show
  end

  def edit
  end

  def new
    @title = "Write a post!"
    @post = Post.new if signed_in?
  end

end
