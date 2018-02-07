class UsersController < ApplicationController
  before_action :set_user, only: [:tweets, :edit, :followings]

  def tweets
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def edit
  end

  def update
  end

  def followings
    # @followings 基於測試規格，必須講定變數名稱
    @followings = @user.followings
  end

  def followers
    @followships = Followship.where(following_id: params[:id])
    # @followers 基於測試規格，必須講定變數名稱
    @followers = User.where(id: @followships.select(:user_id))
  end

  def likes
    # @likes 基於測試規格，必須講定變數名稱
    @likes = Like.where(user_id: params[:id])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
