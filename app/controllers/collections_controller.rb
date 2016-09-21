class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy, :like]

  def index
    @collections = policy_scope(Collection)
  end

  def show
    @comment = Comment.new
  end

  def new
    @collection = Collection.new
    authorize @collection
  end

  def create
    @collection = Collection.new(collection_params)
    @collection.user = current_user
    authorize @collection
    @collection.save
    redirect_to collection_path(@collection)
  end

  def edit
  end

  def update
    authorize @collection
    @collection.update(collection_params)
    redirect_to collection_path(@collection)
  end

  def destroy
    authorize @collection
    @collection.destroy
    redirect_to collections_path
  end

  # non-CRUD actions
  def like
    @user = current_user
    @collection.liked_by current_user
    unless @collection.vote_registered?
      @collection.disliked_by current_user
    end
    respond_to do |format|
      format.js  # <-- like.js.erb
    end
  end

  def follow
    if current_user.following? @collection
      current_user.stop_following @collection
    else
      current_user.follow @collection
    end
  end

  private

  def collection_params
    params.require(:collection).permit(:title, :description)
  end

  def set_collection
    @collection = Collection.find(params[:id])
    authorize @collection
  end

end
