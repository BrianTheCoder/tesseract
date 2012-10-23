class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @projects = Project.all
  end
  
  def show
    @project = Project.find(params[:id])
    @images = @project.images
  end
  
  def create
    project = Project.create(params[:project])
    render json: project
  end
  
  def update
    project = Project.find(params[:id])
    project.update_attributes(params[:project])
    head :ok
  end
  
  def destroy
    project = Project.find(params[:id])
    project.destroy
    head :ok
  end
end
