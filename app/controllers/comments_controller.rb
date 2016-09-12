class CommentsController < ApplicationController
  before_action :set_resource, only: [:create, :update, :destroy]
  before_action :set_comment, only: [:update, :destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.commentable = @resource
    @comment.user = current_user
    if @comment.save
      redirect_to collection_resource_path(@resource.collection, @resource)
    else
      render 'resources/show'
    end
  end

  def update

  end

  def destroy
    @comment.destroy
    redirect_to collection_resource_path(@resource.collection, @resource)

  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def set_resource
    @resource = Resource.find(params[:resource_id])
    authorize @resource
  end

  # def set_collection
  #   @collection = Collection.find(params[:collection_id])
  # end

end
