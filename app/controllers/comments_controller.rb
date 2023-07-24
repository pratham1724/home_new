class CommentsController < ApplicationController
  
  

  def new
    
    # @trainer = Trainer.find(params[:user_id])
    # @post = current_user.trainer.posts.find(params[:trainer_id])
    @post = Post.find(params[:post_id])
    @trainer_1 = @post.trainer_id
    @trainer = Trainer.find(@trainer_1)
    @comment = @post.comments.build
  end
  
  
  def create
    # @trainer = current_user.trainer.find(params[:user_id])
    # @post = current_user.trainer.posts.find(params[:trainer_id])
    @post = Post.find(params[:post_id])
    @trainer_1 = @post.trainer_id
    @trainer = Trainer.find(@trainer_1)
    @comment = @post.comments.new(comment_params)
    if @comment.save 
      redirect_to trainer_post_path(@trainer, @post.id)
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def index

    @post = Post.find(params[:post_id])
    if current_user.role == "client"
      @trainer_1 = @post.trainer_id
      @trainer = Trainer.find(@trainer_1)
    else
      @trainer = current_user.trainer
    end

    # @comment_1 = @post.comments.build
    # @comment = Comments.all
    @comment = @post.comments
  end

  
  def destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :comment)
    end
end
