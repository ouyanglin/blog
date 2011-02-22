module ApplicationHelper

  def title
    base_title = "Exercise 1.1"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
