require 'rubygems'
require 'twitter_oauth'

@@config = YAML.load_file("config.yaml")

class UsersController < ApplicationController
  def request_token
    @client = TwitterOAuth::Client.new(
      :consumer_key    => ENV['CONSUMER_KEY'] || @@config['consumer_key'],
      :consumer_secret => ENV['CONSUMER_SECRET'] || @@config['consumer_secret']
    )

    request_token = @client.request_token(
      :oauth_callback => ENV['CALLBACK_URL'] || @@config['callback_url']
    )

    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret

    redirect_to request_token.authorize_url.gsub('authorize', 'authenticate')
  end

  def access
    @user = current_user

    @client = TwitterOAuth::Client.new(
      :consumer_key    => ENV['CONSUMER_KEY'] || @@config['consumer_key'],
      :consumer_secret => ENV['CONSUMER_SECRET'] || @@config['consumer_secret']
    )

    access_token = @client.authorize(session[:request_token],
                                    session[:request_token_secret],
                                    :oauth_verifier => params[:oauth_verifier])

    if @client.authorized?
      @user.access_token = access_token.token
      @user.access_secret = access_token.secret
      flash[:success] = "it worked!"
      redirect_to dashboard_path
    else
      redirect_to root_path
    end
  end

end
