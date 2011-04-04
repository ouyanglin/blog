class PostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy, :edit, :update]
  def create
    @post = current_user.posts.build(params[:post])
    label = params[:post][:label].split(', ')
    if @post.save
      flash[:success] = "Post created!"
      for l in label
        if !Label.find_by_label_name(l)
          tag=Label.create!(:label_name => l)
        else
          tag=Label.find_by_label_name(l)
        end
        @post.label_posts.create!(:label_id => tag.id)
      end
      redirect_to root_path
    else
      flash[:error] = "Omo! There was an error"
      redirect_to 'posts/new'
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = "Post destroyed."
    redirect_to dashboard_path
  end

  def show
  end

  def edit
    @post = Post.find(params[:id])
    @title = "Edit Post"
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      flash[:success] = "Post updated."
      redirect_to root_path
    else
      @title = "Edit Post"
      render 'edit'
    end
  end

  def new
    @title = "Write a post!"
    @post = Post.new if signed_in?
  end

  private

    def authenticate
      deny_access unless signed_in?
    end

end
