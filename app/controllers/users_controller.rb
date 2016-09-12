class UsersController < ApplicationController
  before_action :set_user, only: [:show, :follow]

  def show
    # @user set by the before_action method
  end

  # Non-CRUD actions

  def follow
    current_user.follow(@user)
    redirect_to user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end
end
