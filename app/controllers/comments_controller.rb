class CommentsController < ApplicationController
  before_action :set_commentable, only: [:create, :update, :destroy]
  before_action :set_comment, only: [:update, :destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.commentable = @commentable
    @comment.user = current_user
    if @comment.save
      @comment.create_activity :create, owner: current_user
      if @comment.commentable.class == Resource
        respond_to do |format|
          format.html { redirect_to collection_resource_path(@commentable.collection, @commentable) }
          format.js  # <-- will render `app/views/comment/create.js.erb`
        end
        # redirect_to collection_resource_path(@commentable.collection, @resource)
      elsif @comment.commentable.class == Collection
        # redirect_to collection_path(@commentable)
        respond_to do |format|
          format.html { redirect_to collection_path(@commentable) }
          format.js  # <-- will render `app/views/comment/create.js.erb`
        end
      end
    else
      if @comment.commentable.is_a? Resource
        respond_to do |format|
          format.html { render 'resources/show' }
          format.js  # <-- idem
        end
      else
        respond_to do |format|
          format.html { render 'collections/show' }
          format.js  # <-- idem
        end
      end
    end
  end

  def update
    # TODO (replace comment item for form to edit the comment)
  end

  def destroy
    @comment.destroy
    # if @commentable.is_a? Resource
    #   redirect_to collection_resource_path(@commentable.collection, @commentable)
    # else
    #   redirect_to collection_path(@commentable)
    # end
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
