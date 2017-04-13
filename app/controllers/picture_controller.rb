class PictureController < ApplicationController

require "twitter"

@@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ""
  config.consumer_secret     = ""
  config.access_token        = ""
  config.access_token_secret = ""
end

  # タイムラインの画像一覧表示
  def index
    @url_list = Array.new
    @@client.home_timeline({count:200}).each do |tweet|
      if tweet.media.empty? == false && tweet.media.length > 0 then
        tweet.media.each do |medium|
          picture_tweet = Hash.new
          picture_tweet[:media_url] = medium.media_url
          picture_tweet[:src_tweet] = "https://twitter.com/"+tweet.user.id.to_s+"/status/"+tweet.id.to_s
          @url_list.push(picture_tweet)
        end
      end
    end
  end

  # お気に入り画像一覧表示
  def show
    @favorites = Favorite.order("created_at desc").limit(100)
  end

  # お気に入りへ追加
  def favorite_add
    @add_tweet = Favorite.new
    @add_tweet.media_url = params[:favorite][:media_url]
    @add_tweet.src_tweet = params[:favorite][:src_tweet]
    @add_tweet.save
    flash[:notice] = "お気に入りへ追加しました"
    redirect_to action: 'index'
  end

  # お気に入りから削除
  def favorite_del
    @id = params[:delete_id]
    @del_favorite = Favorite.find(@id)
    @del_favorite.destroy
    flash[:notice] = "お気に入りから削除しました"
    redirect_to action: 'show'
  end

end
