class InvitesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @invites = current_user.invites.pending
  end
  
  def create
    @invite = group.invites.create(params[:invite].merge(invited_by: current_user))
    InviteMailer.notify(@invite).deliver
    respond_to do |format|
      format.json do
        render json: {
          id: @invite.id,
          name: @invite.name,
          email: @invite.email,
          project_id: project.id
        }
      end
    end
  end
  
  def accept
    @invite = group.invites.find(params[:id])
    group = @invite.group
    group.user_ids << @invite.user_id
    group.save
    @invite.update_attribute(:accepted_at, Time.now)
    head :ok
  end
  
  def destroy
    @invite = group.invites.find(params[:id])
    @invite.destroy
    head :ok
  end
  
  protected
  
  def group
    @_group ||= Group.find(params[:group_id])
  end
end
class InvitesController < ApplicationController
end
