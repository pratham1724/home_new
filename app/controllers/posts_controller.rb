class PostsController < ApplicationController
  before_action :authenticate_user! #to ensure users are signed in to create posts
  before_action :set_trainer, only: [:new, :create, :show, :destroy]
  # load_and_authorize_resource
  def new
    if current_user.role == "client"
      redirect_to client_path(current_user)
    else
      @post = @trainer.posts.new
    end
  end

  def create
    @post = @trainer.posts.new(post_params)
    if @post.save
      redirect_to trainer_post_path(@trainer, @post.id), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def show
    @post = @trainer.posts.paginate(page: params[:page], per_page: 3)
  end

    def destroy
    @post = @trainer.posts.find(params[:id])

    if @post.destroy
      redirect_to trainer_path(@trainer), notice: 'Post was successfully deleted.'
    else
      redirect_to trainer_post_path(@trainer, @post), alert: 'Failed to delete the post.'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, images: [])
  end
  def set_trainer
    @trainer = Trainer.find(params[:trainer_id])
  end
end

