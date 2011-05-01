class LabelsController < ApplicationController

  def show
    label = Label.find(params[:id])
    @title = label.label_name
    @posts = label.posts
    render 'pages/home'
  end

end
