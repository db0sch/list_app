class CommentsController < ApplicationController
  before_action :set_commentable, only: [:create, :update, :destroy]
  before_action :set_comment, only: [:update, :destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.commentable = @commentable
    @comment.user = current_user
    if @comment.save
      if @comment.commentable.class == Resource
        redirect_to collection_resource_path(@commentable.collection, @resource)
      elsif @comment.commentable.class == Collection
        redirect_to collection_path(@commentable)
      end
    else
      if @comment.commentable.is_a? Resource
        render 'resources/show'
      else
        render 'collections/show'
      end
    end
  end

  def update

  end

  def destroy
    @comment.destroy
    if @commentable.is_a? Resource
      redirect_to collection_resource_path(@commentable.collection, @commentable)
    else
      redirect_to collection_path(@commentable)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def set_commentable
    if params[:resource_id]
      @commentable = Resource.find(params[:resource_id])
    else
      @commentable = Collection.find(params[:collection_id])
    end
    authorize @commentable
  end

  # def set_collection
  #   @collection = Collection.find(params[:collection_id])
  # end

end
