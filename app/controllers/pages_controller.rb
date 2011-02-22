class PagesController < ApplicationController
  before_filter :authenticate, :only => [:dashboard]

  def home
    @title = "Home"
  end

  def about
    @title = "About"
  end

  def dashboard
    @title = "Dashboard"
  end

  private

    def authenticate
      deny_access unless signed_in?
    end
end