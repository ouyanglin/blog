class LabelsController < ApplicationController

  def show
    label = Label.find(params[:id])
    @title = label.label_name
    if params[:page]
      @page = params[:page].to_i - 1
    else
      @page = 0
    end
    post_display = 5
    @count = label.posts.count
    offset_num = @page*post_display
    @posts = label.posts.limit(post_display).offset(offset_num)
    render 'pages/home'
  end

end
