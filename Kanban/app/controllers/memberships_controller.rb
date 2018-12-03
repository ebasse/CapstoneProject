class MembershipsController < ApplicationController
    
    def new
       @membership = current_user.memberships.new
    end
    
    def add_member
        @membership = Membership.find(board_id: @board.id)
        @membership.members.create(:member)
        redirect_to @board
    end
    
    def create
        @membership = current_user.memberships.new
        if @membership.save
            print "success"
        else
            redirect_to root_path
        end
    end
    
    def destroy
        @member = User.find(params[:id])
        @membership = Membership.find_by(:user_id => params[:id], :board_id => current_user.current_board)
        @membership.destroy
        respond_to do |format|
            format.html {redirect_to my_members_path(board: current_user.current_board)}
        end
    end
=begin
    def destroy
        @membership = current_user.memberships.where(member_id: params[:id]).first
        @membership.destroy
        flash[:notice] = "Member was successfully removed"
        redirect_to my_members_path
    end
=end    
        
end