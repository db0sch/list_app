class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy, :like, :follow]

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
    @collection.create_activity :create, owner: current_user
    redirect_to collection_path(@collection)
    # do a IF/ELSE statement on the save. in order to prevent errors...
  end

  def edit
  end

  def update
    authorize @collection
    @collection.update(collection_params)
    @collection.create_activity :update, owner: current_user
    redirect_to collection_path(@collection)
    # same here, muste do a IF/ELSE statement to handle errors
  end

  def destroy
    authorize @collection
    @collection.destroy
    redirect_to collections_path
  end

  # non-CRUD actions
  def like
    # refacto the IF ELSE statement in order to create activity only on the like (and not the dislike)
    @user = current_user
    if @user.liked? @collection
      @collection.disliked_by current_user
    else
      @user.likes @collection
    end
    @collection.create_activity :like, owner: current_user
    respond_to do |format|
      format.js  # <-- like.js.erb
    end
  end

  def follow
    if current_user.following? @collection
      current_user.stop_following @collection
    else
      current_user.follow @collection
      @collection.create_activity :follow, owner: current_user
    end
    respond_to do |format|
      format.js  # <-- follow.js.erb
    end
  end

  private

  def collection_params
    params.require(:collection).permit(:title, :description, :tagline, :status)
  end

  def set_collection
    @collection = Collection.find(params[:id])
    authorize @collection
  end

end
