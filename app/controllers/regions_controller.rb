class RegionsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json
  
  def index
    @regions = project.regions
  end
  
  def show
    @region = project.regions.where(identifier: params[:id]).first
  end
  
  protected
  
  def project
    @project ||= Project.find(params[:project_id])
  end
end
