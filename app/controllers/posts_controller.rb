require 'net/http'
require 'cgi'
require 'uri'
require 'rubygems'
require 'twitter_oauth'

@@config = YAML.load_file("config.yaml")

class PostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy, :edit, :update]
  def create
    @post = current_user.posts.build(params[:post])
    label = params[:post][:label].split(', ')
    if @post.save
      flash[:success] = "Post created!"

      #create the new labels
      for l in label
        if !Label.find_by_label_name(l)
          tag=Label.create!(:label_name => l)
        else
          tag=Label.find_by_label_name(l)
        end
        @post.label_posts.create!(:label_id => tag.id)
      end

      #update the twitter account
      user = current_user
      client = TwitterOAuth::Client.new(
        :consumer_key => ENV['CONSUMER_KEY'] || @@config['consumer_key'],
        :consumer_secret => ENV['CONSUMER_SECRET'] || @@config['consumer_secret'],
        :token => user.access_token,
        :secret => user.access_secret
      )

      #Use bitly to create a short URL of the post
      post_url = "http://exerciseoneone.com/posts/"
      post_url << @post.named_route

      bitly_uri = URI.parse("http://api.bitly.com/v3/shorten")
      bitly_uri.query = "login=#{@@config['login']}"
      bitly_uri.query << "&apiKey=#{@@config['apiKey']}"
      bitly_uri.query << "&longUrl=#{CGI.escape(post_url)}"
      bitly_uri.query << "&format=json"

      req = Net::HTTP::Get.new(bitly_uri.to_s, nil)
      http_object = Net::HTTP.new(bitly_uri.host, bitly_uri.port)
      resp = http_object.request(req)

      short_url = ActiveSupport::JSON.decode(resp.body)["data"]["url"]

      client.update("New post on E1.1: #{@post.title} #{short_url}")
      redirect_to root_path
    else
      flash[:error] = "Omo! There was an error"
      redirect_to 'posts/new'
    end
  end

  def destroy
    p = Post.find(params[:id])
    label = p.labels
    for l in label
      if l.posts.count <= 1
        l.destroy
      end
    end
    p.destroy
    flash[:success] = "Post destroyed."
    redirect_to dashboard_path
  end

  def show
    @post = Post.find_by_title(params[:title])
    @title = @post.title
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
