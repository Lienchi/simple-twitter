class TweetsController < ApplicationController

  def index
    @tweet = Tweet.new
    @tweets = Tweet.order(updated_at: :desc)
    # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users = User.order(followers_count: :desc).limit(10)
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      #flash[:notice] = 'tweet was successfully created'
    else
      #flash[:alert] = @tweet.errors.full_messages.to_sentence
    end
    redirect_to tweets_url
  end

  def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    @tweet.count_likes
    #redirect_back(fallback_location: root_path)
    redirect_to tweets_path #fit spec
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    likes = Like.where(tweet: @tweet, user: current_user)
    likes.destroy_all
    @tweet.count_likes
    #redirect_back(fallback_location: root_path)
    redirect_to tweets_path #fit spec
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
