class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]

  def index
    @collections = Collection.all
  end

  def show

  end

  def new
    @collection = Collection.new
  end

  def create
    @collection = Collection.new(collection_params)
    @collection.user = current_user
    @collection.save
    redirect_to collection_path(@collection)
  end

  def edit
  end

  def update
    @collection.update(collection_params)
    redirect_to collection_path(@collection)
  end

  def destroy
    @collection.destroy
    redirect_to collections_path
  end

  private

  def collection_params
    params.require(:collection).permit(:title, :description)
  end

  def set_collection
    @collection = Collection.find(params[:id])
  end

end
