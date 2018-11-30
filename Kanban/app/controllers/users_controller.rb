class UsersController < ApplicationController
    
    #def method_name
        
    #end
    def my_members
        @memberships = current_user.members
    end
end