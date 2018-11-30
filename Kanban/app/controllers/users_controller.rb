class UsersController < ApplicationController
    
    #def method_name
        
    #end
    def my_members
        @memberships = current_user.members
    end
    
    def search
        if params[:search_param].blank?
            flash.now[:danger] = "Oops! Enter users name or email"
        else
            @users = User.search(params[:search_param])
            flash.now[:danger] = "No users match this search criteria" if @users.blank?
        end
        respond_to do |format|
            format.js { render partial: 'members/result' }
        end
    end
end