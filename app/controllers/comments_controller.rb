class CommentsController < ApplicationController
  before_action :set_post, only: [:new, :create, :index, :destroy]
  before_action :set_trainer, only: [:new, :create]

  def new
    @comment = @post.comments.new()
  end
  
  def create
    @comment = @post.comments.new(comment_params.merge(commenter: current_user.client.name))
    if @comment.save 
      redirect_to trainer_post_path(@trainer, @post.id)
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def index
    if current_user.role == "client"
      @trainer = Trainer.find(@post.trainer_id)
    else
      @trainer = current_user.trainer
    end
    @comment = @post.comments
  end

  
  def destroy
    @comment = @post.comments.find(params[:id])

    if @comment.destroy
      redirect_to trainer_post_path(@post.trainer, @post), notice: 'Comment was successfully deleted.'
    else
      redirect_to trainer_post_path(@post.trainer, @post), alert: 'Failed to delete the comment.'
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :comment)
    end

    def set_post
      @post = Post.find(params[:post_id])
    end
    
    def set_trainer
      @trainer = Trainer.find(@post.trainer_id)
    end

end
