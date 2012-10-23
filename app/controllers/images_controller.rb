class ImagesController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @image = project.images.find(params[:id])
    @regions = @image.regions
  end
  
  def create
    @image = project.images.new(params[:image])
    @image.user = current_user
    @image.save
    render json: image
  end
  
  def train
    image = project.images.find(params[:id])
    region = image.regions.new(params[:region])
    region.user = current_user
    region.save
    head :ok
  end
  
  def untrain
    image = project.images.find(params[:id])
    region = image.regions.find(params[:region_id])
    # region.destroy
    head :ok
  end
  
  def destroy
    image = project.images.find(params[:id])
    image.destroy
    head :ok
  end
  
  protected
  
  def project
    @project ||= Project.find(params[:project_id])
  end
end
