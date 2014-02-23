class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def new
    @topics = Topic.new
    authorize! :create, @topic, message: "You need to be an admin to do that."
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def create
    @topic = Topic.new(params[:id])
    if @topic.save
      redirect_to @topic, notice: "Topic was save successfully."
    else
      flash[:error] = "Error creating topic. Please try again."
      render :new
    end
end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(params[:id])
      redirect_to @topic, notice: "Topic was saved successfully"
    else
      flash[:error] = "Error saving topoc, Please try again."
      render :edit
    end
 end
end
