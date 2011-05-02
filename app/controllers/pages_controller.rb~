class PagesController < ApplicationController
  before_filter :authenticate, :only => [:dashboard]

  def home
    @title = "Home"
    if params[:page]
      @page = params[:page].to_i - 1
    else
      @page = 0
    end
    post_display = 5
    @count = Post.count
    offset_num = @page*post_display
    @posts = Post.limit(post_display).offset(offset_num)
  end

  def about
    @title = "About"
  end

  def dashboard
    @title = "Dashboard"
    @posts = Post.all
  end

  private

    def authenticate
      deny_access unless signed_in?
    end
end
