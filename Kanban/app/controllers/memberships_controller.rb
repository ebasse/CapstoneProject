class MembershipsController < ApplicationController
    
    def destroy
        @membership = current_user.memberships.where(member_id: params[:id]).first
        @membership.destroy
        flash[:notice] = "Member was successfully removed"
        redirect_to my_members_path
    end
    
end