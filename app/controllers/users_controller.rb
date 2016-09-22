class UsersController < ApplicationController
  before_action :set_user, only: [:show, :follow, :follow]

  def show
    # @user set by the before_action method
  end

  # Non-CRUD actions

  def follow
    if current_user.following? @user
      current_user.stop_following @user
    else
      current_user.follow @user
    end

    respond_to do |format|
      format.js  # <-- users/follow.js.erb
    end

  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end
end
