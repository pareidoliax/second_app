class PostsController < ApplicationController
  def index
      @posts = Post.new
  end

  def show
      @post = Post.find(params[:id])
  end

  def new
  end

  def edit
  end
end
