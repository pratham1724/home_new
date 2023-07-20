class PostsController < ApplicationController
  before_action :authenticate_user! # Add this line to ensure users are signed in to create posts

  def new
    # @trainer = current_user.trainer # Assign the current trainer creating the post
    # @user = User.find(params[:trainer_id])
    @trainer = Trainer.find(params[:trainer_id])
    @post = @trainer.posts.new
  end

  def create
    # @trainer = current_user.trainer # Assign the current trainer creating the post

    # @post = current_user.posts.new(post_params)
    @trainer = Trainer.find(params[:trainer_id])
    @post = @trainer.posts.new(post_params)

    if @post.save
      redirect_to trainer_post_path(@trainer, @post.id), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def show
    
    # if @post.nil?
    #   redirect_to trainer_post_path, alert: 'Post not found.'
    # else
    #   @trainer = Trainer.find(params[:trainer_id])
    #   @post = @trainer.posts.find(params[:id])
    # end
    @trainer = Trainer.find(params[:trainer_id])
    @post = @trainer.posts
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end

