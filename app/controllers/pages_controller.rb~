class PagesController < ApplicationController
  before_filter :authenticate, :only => [:dashboard]

  def home
    @title = "Home"
    @posts = Post.all
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
