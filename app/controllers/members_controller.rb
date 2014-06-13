class MembersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json
  
  def index
    @memberships = project.memberships
  end
  
  def create
    membership = project.memberships.create(params[:membership])
    MembershipMailer.notify(membership).deliver
    render json: membership
  end
  
  def update
    membership = project.memberships.find(params[:id])
    membership.access = params[:membership][:access]
    membership.save
    render json: membership
  end
  
  def destroy
    membership = project.memberships.find(params[:id])
    membership.destroy
    render json: membership
  end
  
  protected
  
  def project
    @project ||= Project.find(params[:project_id])
  end
end
